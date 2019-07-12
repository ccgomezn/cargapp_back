Rails.application.routes.draw do
  get 'home/index'
  get 'home/user_information'
  
  devise_for :users
  resources :roles

  namespace :api, defaults: { format: :json } do
    namespace :v1, defaults: { format: :json } do
      get 'roles/active' => 'roles#active'
      resources :roles
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
