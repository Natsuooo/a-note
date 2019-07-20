# Preview all emails at http://localhost:3000/rails/mailers/register_mailer
class RegisterMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/register_mailer/register_account
  def register_account
    RegisterMailer.register_account
  end

end
