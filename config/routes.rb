Rails.application.routes.draw do    
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  use_doorkeeper

  root 'home#index'
  get 'home/user_information'

  devise_for :users
  resources :roles
  resources :user_roles
  resources :cargapp_models
  resources :parameters
  resources :permissions
  resources :status
  resources :countries
  resources :states
  resources :cities

  namespace :api, defaults: { format: :json } do
    namespace :v1, defaults: { format: :json } do
      resources :users #, only: [:create, :update, :show]
      # -------------------
      get 'roles/active' => 'roles#active'
      resources :roles
      get 'user_roles/active' => 'user_roles#active'
      resources :user_roles
      get 'cargapp_models/active' => 'cargapp_models#active'
      resources :cargapp_models
      get 'parameters/active' => 'parameters#active'
      resources :parameters
      get 'permissions/active' => 'permissions#active'
      resources :permissions
      get 'status/active' => 'status#active'
      resources :status
      get 'countries/active' => 'countries#active'
      get 'countries/migration' => 'countries#migration'
      resources :countries
      get 'states/active' => 'states#active'
      resources :states
      get 'cities/active' => 'cities#active'
      resources :cities
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
