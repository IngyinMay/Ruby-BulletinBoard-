Rails.application.routes.draw do

  root 'login#login'

  resources :users, only: [:index, :show, :destroy] do
    collection do
      get :new_user, to: "users#new"
      post :new_user
      get :profile
      get :edit_profile
      put :edit_profile, to: "users#update_profile"
      get :edit_password
      put :edit_password, to: "users#change_password"
    end
    member do
      get :edit
      put :edit, to: 'users#update'
    end
  end

  resources :posts, only: [:index, :show, :destroy] do
    collection do
      get :new_post, to: "posts#new"
      post :new_post
      get :filter
      get :search
      get :download_csv
      get :csv_format
      get :upload_csv
      post :import_csv
    end
    member do
      get :edit
      put :edit, to: "posts#update"
    end
  end

  # login
  get '/login', to: 'login#login'
  post '/login', to: 'login#actionLogin'
  get '/logout', to: 'login#logout'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
