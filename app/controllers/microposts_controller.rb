class MicropostsController < ApplicationController
  
  protect_from_forgery except: [:create, :update, :destroy, :trash]
  
  before_action :logged_in_user, only: [:create, :update, :destroy, :edit, :new, :trash]
  
  def new
    @micropost=current_user.microposts.build 
    @micropost.title="無題のノート"
    @micropost.save
    @memo_items=current_user.memo
  end
  
  def create
    @user=current_user
    @micropost=@user.microposts.build(micropost_params)
    if @micropost.save
      if @micropost.title==""
        @micropost.update(title: "無題のノート")
      end
      @memo_items=current_user.memo
#      render :json => @micropost
#      results={message: @micropost.title}
#      render partial: "ajax_partial", locals: {results: results}
#      redirect_to @user
    else
      @memo_items=[]
      render 'new'
    end
  end
  
  def edit
    @micropost=Micropost.find(params[:id])
  end
  
  def update
#    @micropost=Micropost.find(params[:id])
#    if @micropost.update("title": params[:title], "body": params[:body])
#      if @micropost.title==""
#        @micropost.update(title: "無題のノート")
#      end
#      redirect_to current_user
#    else
#      @memo_items=[]
#      render 'edit'
#    end
    
    @micropost=Micropost.find(params[:id])
    if @micropost.update_attributes(micropost_params)
      @memo_items=current_user.memo
    else
      @memo_items=[]
      render 'edit'
    end
    
    
#    Micropost.find(params[:id]).destroy
#    @user=current_user
#    @micropost=@user.microposts.build(micropost_params)
#    if @micropost.update
#      if @micropost.title==""
#        @micropost.update(title: "無題のノート")
#      end
#      @memo_items=current_user.memo
#      redirect_to @user
#      results={:message => @micropost.title}
#      render partial: 'ajax_partial', locals: {:resuts => results}
#    else
#      @memo_items=[]
#      render 'edit'
#    end
  end
  
  def trash
    @user=current_user
    @to_trash=Micropost.find(params[:id])
#    if @micropost.update(trash: true)
    if @to_trash.update(trash: true)
#      render ('trash')
#      redirect_to @user
      @memo_items=current_user.memo
      @micropost=current_user.form
    else
      render 'edit'
    end
  end
  
  def destroy
    Micropost.find(params[:id]).destroy
    @user=current_user
    @memo_items=Micropost.where(user_id: @user.id, trash: true)
    @trash=Micropost.where(user_id: @user.id, trash: true).first
#    redirect_to action: "trash_index"
  end
  
  def trash_index
    @user=current_user
    @memo_items=Micropost.where(user_id: @user.id, trash: true)
    @trash=Micropost.where(user_id: @user.id, trash: true).first
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
  
  def ajax_form
    @micropost=Micropost.find(params[:id]);
  end
  
#  def sync
#    @memo_items=current_user.memo
#    @micropost=current_user.form
#  end
  
  def back_to_index
    @memo_items=current_user.memo
    @micropost=current_user.form
  end
  
  private
    
    def micropost_params
      params.require(:micropost).permit(:title, :body)
    end
  
end
