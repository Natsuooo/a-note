class UserMailer < ApplicationMailer

  def password_reset(user)
    @user=user
    mail to: user.email, subject: "A-note | パスワードを再設定する"
  end
  
end
