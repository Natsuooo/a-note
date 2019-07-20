class MicropostsController < ApplicationController
  
  protect_from_forgery except: [:create, :update, :destroy, :trash]
  
  before_action :logged_in_user, only: [:create, :update, :destroy, :edit, :new, :trash]
  
  def new
    @micropost=current_user.microposts.build 
#    @micropost.title="無題のノート"
#    if params[:title]==""
#      params[:title]="無題のノート"
#    end
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
    
    
    
    if params[:title]==""
      params[:title]="無題のノート"
    end
    
    if @micropost.update_attributes(micropost_params)
#      if @micropost.title==""
#        @micropost.update(title: "無題のノート")
#      end
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
    @trash=Micropost.find(params[:id])
#    if @micropost.update(trash: true)
    @count=Micropost.where(user_id: @user.id, trash: false).count
    if @count=="1"
      @micropost=[]
    else  
      @micropost=current_user.form
    end
    if @trash.update(trash: true)
#      render ('trash')
#      redirect_to @user
      @memo_items=current_user.memo
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
#    @user=current_user
#    @memo_items=Micropost.where(user_id: @user.id, trash: true)
#    @trash=Micropost.where(user_id: @user.id, trash: true).first
    
    @user=current_user
    @memo_items=Micropost.where(user_id: params[:id], trash: true)
    @trash=Micropost.where(user_id: params[:id], trash: true).first
  end
  
    
  
  def android_get_memo
    if params[:pass]=='sE33crxWxdNL' 
      micropost=Micropost.where(user_id: params[:user_id], trash: params[:is_trash])
      memo={
        datas: micropost.each do |f| 
          { 
          id: f.id,
          title: f.title,
          body: f.body,
          updated_at: f.updated_at.to_s
          }
        end
  #      data: "a"
      }
      render :json => memo
    end
  end  
  
  
  def android_get_edit_memo
    if params[:pass]=='sE33crxWxdNL' 
    micropost=Micropost.find(params[:memo_id])
      memo={
        id: micropost.id,
        title: micropost.title,
        body: micropost.body,
        updated_at: micropost.updated_at.to_s
        }
      render :json => memo
    end
  end
  
  def android_insert_memo
    if params[:pass]=='sE33crxWxdNL'
      if params[:memo_id]=="0"
#        新規作成の場合
        @user=User.find(params[:user_id])
        @micropost=@user.microposts.build({title: params[:title], body: params[:body]})
        @micropost.save
      else
#        更新の場合
        @micropost=Micropost.find(params[:memo_id])
        if params[:title]==""
          params[:title]="無題のノート"
        end
        @micropost.update({title: params[:title], body: params[:body], trash: false})
      end
    end
  end
  
  def android_trash
    if params[:pass]=='sE33crxWxdNL'
      @micropost=Micropost.find(params[:memo_id])
      @micropost.update({trash: true})
    end
  end
  
  def android_delete
    if params[:pass]=='sE33crxWxdNL'
      Micropost.find(params[:memo_id]).destroy
    end
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
    @user=current_user
  end
  
  def restore
   
    @micropost=Micropost.find(params[:id])
    if @micropost.update(trash: false)
      @user=current_user
      @memo_items=Micropost.where(user_id: @user.id, trash: true)
      @trash=Micropost.where(user_id: @user.id, trash: true).first
    end
  end
  
  def trash_view
    @trash=Micropost.find(params[:id])
  end
  
  def mobile_new
    @user=current_user
    @micropost=@user.microposts.build 
    @micropost.save
  end
  
  def mobile_update
    @micropost=Micropost.find(params[:id])
    
    if params[:micropost][:title]==""
      params[:micropost][:title]="無題のノート"
    end
    @micropost.update_attributes(micropost_params)
    
#    if @micropost.update_attributes(micropost_params)
#      if @micropost.title==""
#        @micropost.update(title: "無題のノート")
#      end
#    else
#      redirect to current_user
#    end
  end
  
  def mobile_edit
    @user=current_user
    @micropost=Micropost.find(params[:id])
  end
  
  def mobile_trash
    @micropost=Micropost.find(params[:id])
    if @micropost.update(trash: true)
      @memo_items=current_user.memo
      @user=current_user
    else
      render 'edit'
    end
  end
  
  def mobile_trash_index
    @user=current_user
    @memo_items=Micropost.where(user_id: params[:id], trash: true)
    @micropost=Micropost.where(user_id: params[:id], trash: true).first
  end
  
  def mobile_trash_view
    @trash=Micropost.find(params[:id])
    @user=current_user
  end
  
  def mobile_back_to_index
    @micropost=Micropost.find(params[:id])
    if params[:title]==""
      params[:title]="無題のノート"
    end
    @micropost.update_attributes(title: params[:title], body: params[:body])
    
    redirect_to "/users/#{@micropost.user_id}"
  end
  
  def mobile_restore
    @micropost=Micropost.find(params[:id])
    if @micropost.update(trash: false)
      @user=current_user
      @memo_items=Micropost.where(user_id: @user.id, trash: true)
      @trash=Micropost.where(user_id: @user.id, trash: true).first
    end
  end
  
  def mobile_delete
    Micropost.find(params[:id]).destroy
    @user=current_user
    @memo_items=Micropost.where(user_id: @user.id, trash: true)
    @trash=Micropost.where(user_id: @user.id, trash: true).first
    
  end
  
  def mobile_delete_from_trash_view
    trash=Micropost.find(params[:id])
    trash.destroy
#    @trash=Micropost.find(params[:id])
    redirect_to "/users/#{trash.user_id}/trash"
    #    @memo_items=Micropost.where(user_id: @user.id, trash: true)
    #    @trash=Micropost.where(user_id: @user.id, trash: true).first
  end
  
  def mobile_restore_from_trash_view
    @micropost=Micropost.find(params[:id])
    if @micropost.update(trash: false)
      @user=current_user
      @memo_items=Micropost.where(user_id: @user.id, trash: true)
    end
    redirect_to "/users/#{@micropost.user_id}/trash"
  end
  
  
  
  private
    
    def micropost_params
      params.require(:micropost).permit(:title, :body)
    end
  
end
