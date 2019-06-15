class UsersController < ApplicationController
  protect_from_forgery except: :create
  
  before_action :logged_in_user, only: :show
  before_action :correct_user, only: :show
  
  def show
    @user = User.find(params[:id])
  end
    
  def new
    @user=User.new
  end
  
  def create
    @user=User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = 'シンプルで使いやすいクラウドメモ帳・ノートアプリ「A-note」へようこそ！'
      redirect_to @user
    else
      render 'new'
    end
    
  end
  
  
  private
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
  
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger]="ログインして下さい。"
        redirect_to login_url
      end
    end
  
    def correct_user
      @user=User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
