# Preview all emails at http://localhost:3000/rails/mailers/usermailer_mailer
class UsermailerMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/usermailer_mailer/invitation
  def invitation
    user = User.first
    UsermailerMailer.with(user: user).invitation
  end

end
