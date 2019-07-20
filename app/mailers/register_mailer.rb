class RegisterMailer < ApplicationMailer

  def register_account(user)
    @user=user
    mail to: user.email, subject: "A-note | ご登録ありがとうございます"
  end
end
