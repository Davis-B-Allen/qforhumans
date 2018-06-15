class GenerateAndSendPngsJob < ApplicationJob
  queue_as :default

  def perform(pdf_file, dpi, email)
    PdfConverter.create_images pdf_file, dpi, email
    File.delete(pdf_file) if File.exist?(pdf_file)
  end
end
