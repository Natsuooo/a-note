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
  
  resources :users
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :microposts
  
end
