Rails.application.routes.draw do
  get 'static_pages/home'

  get 'users/index'

  get 'users/new'

  get 'profiles/show'

  devise_for :users, :controllers => { registrations: 'registrations' }  
  match '/users',   to: 'users#index',   via: 'get'
  match 'users/:id' => 'users#destroy', :via => :delete, :as => :admin_destroy_user
  resources :relationships,only: [:create, :destroy]
  resources :users, :only =>[:show]
  resources :users do
    member do
      get :following, :followers
    end
  end
  root 'posts#index'
  get 'FollowingFeed', to: 'static_pages#home', as: :feed
  get ':user_name', to: 'profiles#show', as: :profile
  get ':user_name/edit', to: 'profiles#edit', as: :edit_profile
  patch ':user_name/edit', to: 'profiles#update', as: :update_profile
  resources :posts do  
    resources :comments
    member do 
      get 'like', to: 'posts#like'
      get 'unlike', to: 'posts#unlike'
    end
    as :user do
      get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'    
      put 'users' => 'devise/registrations#update', :as => 'user_registration'            
    end
    end 
end
