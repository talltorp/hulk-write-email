# Preview all emails at http://localhost:3000/rails/mailers/bounce_mailer
class BounceMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/bounce_mailer/missing_user
  def missing_user
    BounceMailer.missing_user
  end

end
