class UsersController < ApplicationController
  protect_from_forgery except: :create
  
  before_action :logged_in_user, only: :show
  before_action :correct_user, only: :show
  before_action :check_user_agent
  
  def show
    @user = User.find(params[:id])
    @memo_items=current_user.memo
#    @micropost=current_user.microposts.build 
    @micropost=current_user.form
  end
  
    
  def new
    @user=User.new
  end
  
  def create
    @user=User.new(user_params)
    if @user.save
      log_in @user
      remember @user
      flash[:success] = 'シンプルで使いやすいクラウドメモ帳・ノートアプリ「A-note」へようこそ！'
      redirect_to @user
    else
      render 'new'
    end
    
  end
  
  def android_register
    if params[:pass]=='sE33crxWxdNL'
      @user=User.new(email: params[:user_email].downcase, password: params[:user_password])
      if @user.save
        data={data: @user.id}
        render :json => data
      else
        data={data: "NG"}
        render :json => data
      end
    end
  end
  
  
  private
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
  
    def correct_user
      @user=User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
  
  
  
    def check_user_agent
#      ua=request.env["HTTP_USER_AGENT"]
#      if(ua.include?('Mobile') || ua.include?('Android'))
#        redirect_to 
#      end
    end  
end
