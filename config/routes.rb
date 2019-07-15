Rails.application.routes.draw do
  resources :cargapp_models
  resources :user_roles
  get 'home/index'
  get 'home/user_information'
  
  devise_for :users
  resources :roles

  namespace :api, defaults: { format: :json } do
    namespace :v1, defaults: { format: :json } do
      get 'roles/active' => 'roles#active'
      resources :roles
      resources :users#, only: [:create, :update, :show]
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
