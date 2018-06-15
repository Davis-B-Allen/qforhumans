class PdfConverter

  require 'zip'

  def self.create_images(path_to_pdf, dpi, email)
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
    zipfile_name = "cards.zip"
    zipfile = Rails.root.join("tmp/#{zipfile_name}")
    File.delete(zipfile) if File.exist?(zipfile)
    Zip::File.open(zipfile, Zip::File::CREATE) do |z| # creates zipfile
      (0..num_pages-1).each do |p|
        filename = num_pages == 1 ? "card.png" : "card-#{p}.png"
        path_to_png = Rails.root.join("tmp/#{filename}")
        z.add(filename, path_to_png)
      end
    end
    # Delete all files except the zipfile
    (0..num_pages-1).each do |p|
      filename = num_pages == 1 ? "card.png" : "card-#{p}.png"
      path_to_png = Rails.root.join("tmp/#{filename}")
      File.delete(path_to_png) if File.exist?(path_to_png)
    end
    ZipMailer.send_zip(email, zipfile_name, zipfile).deliver_now unless email.empty?
    return zipfile
  end

end
