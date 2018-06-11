class PdfConverter

  def self.foo
    puts "foo"
  end

  def self.create_images(path_to_pdf, dpi)
    pdf = MiniMagick::Image.open(path_to_pdf)
    num_pages = pdf.pages.count
    folder = Rails.root.join('tmp')
    input_filenames = []
    # pdf.pages.each_with_index do |page, index|
    #   page.format "png"
    #   filename = "card#{index}.png"
    #   input_filenames << filename
    #   page.write Rails.root.join("tmp/#{filename}") # creates card png file
    # end
    # pdf.pages.each_with_index do |page, index|
    #   filename = "card#{index}.png"
    #   input_filenames << filename
    #   image = Rails.root.join("tmp/#{filename}")
    #   MiniMagick::Tool::Convert.new do |convert|
    #     convert << page.path
    #     # convert.resize("1800x1800")
    #     convert.density(300)
    #     convert << image
    #   end
    #   page.write(image)
    # end
    MiniMagick::Tool::Convert.new do |convert|
      convert.density(dpi)
      convert << path_to_pdf
      convert.quality(100)
      convert << Rails.root.join("tmp/card.png")
    end
    zipfile_name = Rails.root.join("tmp/cards.zip")
    File.delete(zipfile_name) if File.exist?(zipfile_name)
    # Zip::File.open(zipfile_name, Zip::File::CREATE) do |zipfile| # creates zipfile
    #   input_filenames.each do |filename|
    #     zipfile.add(filename, File.join(folder, filename))
    #   end
    # end
    Zip::File.open(zipfile_name, Zip::File::CREATE) do |zipfile| # creates zipfile
      (0..num_pages-1).each do |p|
        filename = num_pages == 1 ? "card.png" : "card-#{p}.png"
        path_to_png = Rails.root.join("tmp/#{filename}")
        zipfile.add(filename, path_to_png)
      end
    end
    # Delete all files except the zipfile
    # input_filenames.each do |filename|
    #   tmpfile = File.join(folder, filename)
    #   File.delete(tmpfile) if File.exist?(tmpfile)
    # end
    (0..num_pages-1).each do |p|
      filename = num_pages == 1 ? "card.png" : "card-#{p}.png"
      path_to_png = Rails.root.join("tmp/#{filename}")
      File.delete(path_to_png) if File.exist?(path_to_png)
    end
    return zipfile_name
  end

end
