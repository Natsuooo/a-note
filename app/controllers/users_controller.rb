class UsersController < ApplicationController
  protect_from_forgery
  
  def show
    @user = User.find(params[:id])
  end
    
  def new
    @user=User.new
  end
  
  def create
    @user=User.new(user_params)
    if @user.save
      flash[:success] = "シンプルで使いやすいクラウドメモ帳・ノートアプリ「A-note」へようこそ！"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  
  private
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
  
end
