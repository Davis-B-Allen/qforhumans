# Preview all emails at http://localhost:3000/rails/mailers/zip_mailer
class ZipMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/zip_mailer/send_zip
  def send_zip
    ZipMailer.send_zip("davis.b.allen@gmail.com", "robots.txt", Rails.root.join("public/robots.txt"))
  end

end
