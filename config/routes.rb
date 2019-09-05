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
  resources :services
  resources :service_documents
  resources :favorite_routes
  resources :cargapp_ads
  resources :user_locations
  resources :service_locations
  resources :bank_accounts
  resources :rate_services
  resources :cargapp_payments
  resources :payments

  namespace :api, defaults: { format: :json } do
    namespace :v1, defaults: { format: :json } do
      get 'users/truora_users' => 'users#truora_users'
      get 'users/truora_user/:id' => 'users#truora_user'
      post 'users/email_verify' => 'users#email_verify'
      post 'users/phone_verify' => 'users#phone_verify'
      post 'users/validate_number' => 'users#validate_number'
      get 'users/me' => 'users#me'
      post 'users/login' => 'users#login'
      put 'users/update_password' => 'users#update_password'
      resources :users #, only: [:create, :update, :show]
      # -------------------
      get 'roles/active' => 'roles#active'
      resources :roles
      get 'user_roles/active' => 'user_roles#active'
      resources :user_roles
      get 'cargapp_models/active' => 'cargapp_models#active'
      resources :cargapp_models
      get 'parameters/active' => 'parameters#active'
      get 'parameters/find/:code' => 'parameters#find'
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
      get 'services/me' => 'services#me' #Last Service active
      get 'services/history' => 'services#history'
      get 'services/active' => 'services#active'
      resources :services
      get 'service_documents/me' => 'service_documents#me' #Last Service active
      get 'service_documents/active' => 'service_documents#active'
      get 'service_documents/find_service/:id' => 'service_documents#find_service'
      resources :service_documents
      get 'favorite_routes/me' => 'favorite_routes#me' #Last Service active
      get 'favorite_routes/active' => 'favorite_routes#active'
      resources :favorite_routes
      get 'cargapp_ads/me' => 'cargapp_ads#me'
      get 'cargapp_ads/active' => 'cargapp_ads#active'
      resources :cargapp_ads
      get 'user_locations/me' => 'user_locations#me'
      get 'user_locations/active' => 'user_locations#active'
      resources :user_locations
      get 'service_locations/me' => 'service_locations#me'
      get 'service_locations/active' => 'service_locations#active'
      resources :service_locations
      get 'bank_accounts/me' => 'bank_accounts#me'
      get 'bank_accounts/active' => 'bank_accounts#active'
      resources :bank_accounts
      get 'rate_services/me' => 'rate_services#me'
      get 'rate_services/active' => 'rate_services#active'
      resources :rate_services
      get 'cargapp_payments/me' => 'cargapp_payments#me'
      get 'cargapp_payments/active' => 'cargapp_payments#active'
      resources :cargapp_payments
      get 'payments/me' => 'payments#me'
      get 'payments/active' => 'payments#active'
      resources :payments
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
