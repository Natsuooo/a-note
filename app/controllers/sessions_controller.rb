class SessionsController < ApplicationController
  protect_from_forgery except: [:create, :destroy]
  
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me]=='1' ? remember(user) : forget(user)
      redirect_back_or user
    else
      flash.now[:danger]='パスワードが違います。'
      render 'new' 
    end  
  end
  
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
  
  def android_login
    user=User.find_by(email: params[:user_email].downcase)
    if user && user.authenticate(params[:user_password]) && params[:pass]==sE33crxWxdNL
      login={login: user.id}
      render :json => login
    else
      login={login: "NG"}
      render :json => login
    end
  end
  
end
