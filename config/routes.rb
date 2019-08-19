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
  resources :document_types
  resources :vehicle_types
  resources :load_types
  resources :cargapp_integrations
  resources :companies
  resources :tickets
  resources :documents
  resources :vehicles
  resources :profiles
  resources :challenges
  resources :user_challenges
  resources :coupons
  resources :user_coupons
  resources :prizes
  resources :user_prizes
  resources :reports
  resources :payment_methods
  resources :user_payment_methods

  namespace :api, defaults: { format: :json } do
    namespace :v1, defaults: { format: :json } do
      post 'users/email_verify' => 'users#email_verify'
      get 'users/me' => 'users#me'
      post 'users/login' => 'users#login'
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
      get 'document_types/active' => 'document_types#active'
      resources :document_types
      get 'vehicle_types/active' => 'vehicle_types#active'
      resources :vehicle_types
      get 'load_types/active' => 'load_types#active'
      resources :load_types
      get 'cargapp_integrations/me' => 'cargapp_integrations#me'
      get 'cargapp_integrations/active' => 'cargapp_integrations#active'
      resources :cargapp_integrations
      get 'companies/me' => 'companies#me'
      get 'companies/active' => 'companies#active'
      resources :companies
      get 'tickets/me' => 'tickets#me'
      get 'tickets/active' => 'tickets#active'
      resources :tickets
      get 'documents/me' => 'documents#me'
      get 'documents/active' => 'documents#active'
      resources :documents
      get 'vehicles/me' => 'vehicles#me'
      get 'vehicles/active' => 'vehicles#active'
      resources :vehicles
      get 'profiles/me' => 'profiles#me'
      get 'profiles/active' => 'profiles#active'
      resources :profiles
      get 'challenges/me' => 'challenges#me'
      get 'challenges/active' => 'challenges#active'
      resources :challenges
      get 'user_challenges/me' => 'user_challenges#me'
      get 'user_challenges/active' => 'user_challenges#active'
      resources :user_challenges
      get 'coupons/me' => 'coupons#me'
      get 'coupons/active' => 'coupons#active'
      resources :coupons
      get 'user_coupons/me' => 'user_coupons#me'
      get 'user_coupons/active' => 'user_coupons#active'
      resources :user_coupons
      get 'prizes/active' => 'prizes#active'
      resources :prizes
      get 'user_prizes/me' => 'user_prizes#me'
      get 'user_prizes/active' => 'user_prizes#active'
      resources :user_prizes
      get 'reports/me' => 'reports#me'
      get 'reports/active' => 'reports#active'
      resources :reports
      get 'payment_methods/active' => 'payment_methods#active'
      resources :payment_methods
      get 'user_payment_methods/me' => 'user_payment_methods#me'
      get 'user_payment_methods/active' => 'user_payment_methods#active'
      resources :user_payment_methods
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
