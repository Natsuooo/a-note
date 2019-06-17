class MicropostsController < ApplicationController
  
  protect_from_forgery except: [:create, :update, :destroy, :trash]
  
  before_action :logged_in_user, only: [:create, :update, :destroy, :edit, :new, :trash]
  
  def new
    @micropost=current_user.microposts.build 
  end
  
  def create
    @user=current_user
    @micropost=@user.microposts.build(micropost_params)
    if @micropost.save
      if @micropost.title==""
        @micropost.update(title: "無題のノート")
      end
      redirect_to @user
    else
      @memo_items=[]
      render 'new'
    end
  end
  
  def edit
    @micropost=Micropost.find(params[:id])
  end
  
  def update
    Micropost.find(params[:id]).destroy
    @user=current_user
    @micropost=@user.microposts.build(micropost_params)
    if @micropost.save
      if @micropost.title==""
        @micropost.update(title: "無題のノート")
      end
      redirect_to @user
    else
      @memo_items=[]
      render 'edit'
    end
  end
  
  def trash
    @user=current_user
    @micropost=Micropost.find(params[:id])
    if @micropost.update(trash: true)
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def destroy
    Micropost.find(params[:id]).destroy
    @user=current_user
    @trash_items=Micropost.where(user_id: @user.id, trash: true)
    redirect_to action: "trash_index"
  end
  
  def trash_index
    @user=current_user
    @trash_items=Micropost.where(user_id: @user.id, trash: true)
  end
  
  def trash_edit
    @micropost=Micropost.find(params[:id])
  end
    
  def android_get_memo
    micropost=Micropost.where(user_id: params[:user_id], trash: false)
    memo={
      datas: micropost.each do |f| 
        { 
        id: f.id,
        title: f.title,
        body: f.body,
        created_at: f.created_at.to_s
        }
      end
#      data: "a"
    }
    render :json => memo
  end  
  
  private
    
    def micropost_params
      params.require(:micropost).permit(:title, :body)
    end
  
end
