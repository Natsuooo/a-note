Rails.application.routes.draw do
  
  root 'static_pages#home'
  
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  get '/users/:id/trash', to: 'microposts#trash_index'
  put '/microposts/:id/edit', to: 'microposts#trash'
  get 'trash/:id', to: 'microposts#trash_edit'
  
  post 'android/login', to: 'sessions#android_login'
  post 'android/get_memo', to: 'microposts#android_get_memo'
  post 'android/register', to: 'users#android_register'
  
  post 'microposts/ajax-update', to: 'microposts#update'
  
  resources :users
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :microposts
  
  
  
end
