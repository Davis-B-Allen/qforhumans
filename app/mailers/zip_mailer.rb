class ZipMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.zip_mailer.send_zip.subject
  #

  # def send_zip
  #   @greeting = "Hi"
  #
  #   mail to: "to@example.org"
  # end

  def send_zip(email, zipfile_name, zipfile_path)
    @greeting = "Hi"
    attachments[zipfile_name] = File.read(zipfile_path)
    mail to: email, subject: "Cards Against Inanity: Generated Cards"
  end

end
