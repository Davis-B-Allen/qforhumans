class PdfConverter

  def self.foo
    puts "foo"
  end

  def self.create_images(path_to_pdf, dpi)
    pdf = MiniMagick::Image.open(path_to_pdf)
    num_pages = pdf.pages.count
    folder = Rails.root.join('tmp')
    input_filenames = []
    MiniMagick::Tool::Convert.new do |convert|
      convert.density(dpi)
      convert << path_to_pdf
      convert.quality(100)
      convert << Rails.root.join("tmp/card.png")
    end
    zipfile_name = Rails.root.join("tmp/cards.zip")
    File.delete(zipfile_name) if File.exist?(zipfile_name)
    Zip::File.open(zipfile_name, Zip::File::CREATE) do |zipfile| # creates zipfile
      (0..num_pages-1).each do |p|
        filename = num_pages == 1 ? "card.png" : "card-#{p}.png"
        path_to_png = Rails.root.join("tmp/#{filename}")
        zipfile.add(filename, path_to_png)
      end
    end
    # Delete all files except the zipfile
    (0..num_pages-1).each do |p|
      filename = num_pages == 1 ? "card.png" : "card-#{p}.png"
      path_to_png = Rails.root.join("tmp/#{filename}")
      File.delete(path_to_png) if File.exist?(path_to_png)
    end
    return zipfile_name
  end

end
