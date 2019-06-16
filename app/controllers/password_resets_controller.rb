class PasswordResetsController < ApplicationController
  
  protect_from_forgery except: [:create, :update]
  
  before_action :get_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]
  
  def new
  end
  
  def create
    @user=User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info]="パスワード再設定用のメールを送信しました。"
      redirect_to login_path
    else
      flash.now[:danger]="メールアドレスが見つかりません。"
      render 'new'
    end
  end

  def edit
  end
  
  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, :blank)
      render 'edit'
    elsif @user.update_attributes(user_params)
      log_in @user
      remember @user
      flash[:success]="パスワードを再設定しました。"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  private
  
    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end
    
    def get_user
      @user=User.find_by(email: params[:email])
    end
    
    def check_expiration
      if @user.password_reset_expired?
        flash[:danger]="パスポート再設定用のリンクは期限切れです。もう一度パスワード再設定用のメールを送信して下さい。"
        redirect_t new_password_reset_url
      end
    end
end
