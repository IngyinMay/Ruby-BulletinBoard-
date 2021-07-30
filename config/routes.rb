Rails.application.routes.draw do

  get 'user/index'
  root "posts#index"

  #replace using resource
  resources :posts, only: [:index, :new, :show, :edit, :destroy]
  post '/posts/new', to: 'posts#create', as: 'create_post'
  put '/posts/:id/edit', to: 'posts#update', as: 'update_post'
  get '/filter', to: 'posts#filter'
  get '/download_csv', to: 'posts#download_csv'
  get '/upload_csv', to: 'posts#upload_csv'
  post '/import_csv', to: 'posts#import_csv'

  resources :users, only: [:index, :new, :show, :edit, :destroy]
  post '/users/new', to: 'users#create', as: 'create_user'
  put '/users/:id/edit', to: 'users#update', as: 'update_user'
  get '/profile', to: 'users#profile'
  get '/edit_profile', to: 'users#edit_profile'
  put '/edit_profile', to: 'users#update_profile'
  get '/password', to: 'users#edit_password'
  put '/password', to: 'users#change_password'

  # login
  get '/login', to: 'login#login'
  post '/login', to: 'login#actionLogin'
  get '/logout', to: 'login#logout'



  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
