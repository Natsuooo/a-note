Rails.application.routes.draw do
  
  root 'static_pages#home'
  
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  get '/users/:id/trash', to: 'microposts#trash_index', as: 'trash_micropost'
  patch '/microposts/:id/trash', to: 'microposts#trash', as: 'to_trash_micropost'
  get 'trash/:id', to: 'microposts#trash_edit'
  
  post 'android/login', to: 'sessions#android_login'
  post 'android/get_memo', to: 'microposts#android_get_memo'
  post 'android/register', to: 'users#android_register'
  
  get 'microposts/:id/ajax_form', to: 'microposts#ajax_form', as: 'ajax_form'
  
#  get 'microposts/sync', to: 'microposts#sync', as: 'sync_microposts'
  
  get 'microposts/back_to_index', to: 'microposts#back_to_index', as: 'back_to_index'
  
  get 'microposts/restore/:id', to: 'microposts#restore', as: 'restore_micropost'
  
  get 'microposts/new/mobile', to: 'microposts#mobile_new', as: 'mobile_new_micropost'
  patch 'microposts/:id/update/mobile', to: 'microposts#mobile_update', as: 'mobile_update_micropost'
  
  get 'microposts/:id/edit/mobile', to: 'microposts#mobile_edit', as: 'mobile_edit_micropost'
  get 'microposts/:id/trash/mobile', to: 'microposts#mobile_trash_index', as: 'mobile_trash_index_micropost'
  get 'microposts/:id/trash/view/mobile', to: 'microposts#mobile_trash_view', as: 'mobile_trash_view_micropost'
  get 'microposts/back_to_index/mobile', to: 'microposts#mobile_back_to_index', as: 'mobile_back_to_index'
  get 'microposts/:id/restore/mobile', to: 'microposts#mobile_restore', as: 'mobile_restore'
  get 'microposts/:id/delete/mobile', to: 'microposts#mobile_delete', as: 'mobile_delete'
  
  
  resources :users
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :microposts
  
  
  
end
