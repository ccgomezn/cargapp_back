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
  resources :company_users
  resources :service_users
  resources :rooms
  resources :room_users
  resources :messages

  namespace :api, defaults: { format: :json } do
    namespace :v1, defaults: { format: :json } do
      get 'users/top' => 'users#top'
      get 'users/statistics' => 'users#statistics'
      get 'users/truora_users' => 'users#truora_users'
      get 'users/truora_user/:id' => 'users#truora_user'
      post 'users/truora_check_user' => 'users#truora_check_user'      
      post 'users/email_verify' => 'users#email_verify'
      post 'users/phone_verify' => 'users#phone_verify'
      post 'users/validate_number' => 'users#validate_number'
      post 'users/resend_code' => 'users#resend_code'
      get 'users/me' => 'users#me'
      get 'users/temporarily/:id' => 'users#destroy_temporarily'
      post 'users/login' => 'users#login'
      put 'users/update_password' => 'users#update_password'
      post 'users/reset_password' => 'users#reset_password'      
      post 'users/new_password' => 'users#new_password'      
      get 'users/check' => 'users#check'      
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
      get 'permissions/me' => 'permissions#me'
      resources :permissions
      get 'status/active' => 'status#active'
      get 'status/find_model/:id' => 'status#find_model'
      resources :status
      get 'countries/active' => 'countries#active'
      get 'countries/migration' => 'countries#migration'
      resources :countries
      get 'states/active' => 'states#active'
      resources :states
      get 'cities/active' => 'cities#active'
      resources :cities
      get 'document_types/by_category/:category' => 'document_types#by_category'
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
      get 'companies/find_users/:id' => 'companies#find_users'
      resources :companies
      get 'tickets/me' => 'tickets#me'
      get 'tickets/active' => 'tickets#active'
      get 'company_users/active' => 'company_users#active'
      get 'company_users/me' => 'company_users#me'
      get 'company_users/find_company/:id' => 'company_users#find_company'
      resources :company_users
      resources :tickets
      get 'documents/me' => 'documents#me'
      get 'documents/active' => 'documents#active'
      post 'documents/find_user' => 'documents#find_user'      
      resources :documents
      get 'vehicles/me' => 'vehicles#me'
      get 'vehicles/active' => 'vehicles#active'
      resources :vehicles
      get 'profiles/me' => 'profiles#me'
      get 'profiles/active' => 'profiles#active'
      get 'profiles/find_user/:id' => 'profiles#find_user'
      resources :profiles
      get 'challenges/me' => 'challenges#me'
      get 'challenges/active' => 'challenges#active'
      resources :challenges
      get 'user_challenges/top' => 'user_challenges#top'
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
      post 'reports/find_user' => 'reports#find_user'
      resources :reports
      get 'payment_methods/active' => 'payment_methods#active'
      resources :payment_methods
      get 'user_payment_methods/me' => 'user_payment_methods#me'
      get 'user_payment_methods/active' => 'user_payment_methods#active'
      resources :user_payment_methods
      get 'services/destinations' => 'services#destinations'
      get 'services/filter/:start_price/:end_price/:vehicle_type/:created_at/:origin/:destination' => 'services#filter' #Last Service active
      get 'services/me' => 'services#me' #Last Service active
      get 'services/find_driver/:id' => 'services#find_driver' #Last Service active
      post 'services/find_driver' => 'services#find_driver' #Last Service active
      get 'services/find_company/:id' => 'services#find_company' #Last Service active
      get 'services/find_receiver/:id' => 'services#find_receiver' #Last Service active
      get 'services/find_vehicle/:id' => 'services#find_vehicle' #Last Service active
      get 'services/history' => 'services#history'
      get 'services/active' => 'services#active'
      resources :services
      get 'service_users/me' => 'service_users#me'
      get 'service_users/active' => 'service_users#active'
      get 'service_users/approved' => 'service_users#approved'
      get 'service_users/find_service/:id' => 'service_users#find_service'
      resources :service_users
      get 'service_documents/me' => 'service_documents#me' #Last Service active
      get 'service_documents/active' => 'service_documents#active'
      get 'service_documents/find_service/:id' => 'service_documents#find_service'
      resources :service_documents
      get 'favorite_routes/me' => 'favorite_routes#me' #Last Service active
      get 'favorite_routes/active' => 'favorite_routes#active'
      post 'favorite_routes/find_user' => 'favorite_routes#find_user'
      resources :favorite_routes
      get 'cargapp_ads/me' => 'cargapp_ads#me'
      get 'cargapp_ads/active' => 'cargapp_ads#active'
      resources :cargapp_ads
      get 'user_locations/me' => 'user_locations#me'
      get 'user_locations/find_user/:id' => 'user_locations#find_user'
      get 'user_locations/active' => 'user_locations#active'
      resources :user_locations
      get 'service_locations/me' => 'service_locations#me'
      get 'service_locations/active' => 'service_locations#active'
      resources :service_locations
      get 'bank_accounts/me' => 'bank_accounts#me'
      get 'bank_accounts/active' => 'bank_accounts#active'
      resources :bank_accounts
      get 'rate_services/me' => 'rate_services#me'
      get 'rate_services/find_user/:id' => 'rate_services#find_user'
      get 'rate_services/find_service/:id' => 'rate_services#find_service'
      get 'rate_services/find_driver/:id' => 'rate_services#find_driver'
      get 'rate_services/point_user/:id' => 'rate_services#point_user'
      get 'rate_services/point_driver/:id' => 'rate_services#point_driver'
      get 'rate_services/active' => 'rate_services#active'
      resources :rate_services
      get 'cargapp_payments/me' => 'cargapp_payments#me'
      post 'cargapp_payments/find_user' => 'cargapp_payments#find_user'
      post 'cargapp_payments/find_receiver' => 'cargapp_payments#find_receiver'
      post 'cargapp_payments/find_generator' => 'cargapp_payments#find_generator'
      post 'cargapp_payments/find_company' => 'cargapp_payments#find_company'
      get 'cargapp_payments/active' => 'cargapp_payments#active'
      resources :cargapp_payments
      get 'payments/me' => 'payments#me'
      get 'payments/active' => 'payments#active'
      post 'payments/find_user' => 'payments#find_user'
      resources :payments
      get 'rooms/close_rooms' => 'rooms#close_rooms'
      get 'rooms/me' => 'rooms#me'
      get 'rooms/active' => 'rooms#active'
      resources :rooms
      get 'room_users/me' => 'room_users#me'
      get 'room_users/active' => 'room_users#active'
      get 'room_users/users_service/:id' => 'room_users#users_service'
      get 'room_users/users_room/:id' => 'room_users#users_room'
      get 'room_users/check/:id' => 'room_users#check'
      resources :room_users
      get 'messages/me' => 'messages#me'
      get 'messages/active' => 'messages#active'
      get 'messages/room/:id' => 'messages#room'
      resources :messages
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
