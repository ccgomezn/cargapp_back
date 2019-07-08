Rails.application.routes.draw do
  resources :roles

  namespace :api, defaults: { format: :json } do
    namespace :v1, defaults: { format: :json } do
      resources :roles
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
