json.extract! cargapp_integration, :id, :name, :description, :provider, :code, :url, :url_provider, :url_production, :url_develop, :email, :username, :password, :phone, :pin, :token, :app_id, :client_id, :api_key, :user_id, :active, :created_at, :updated_at
json.url cargapp_integration_url(cargapp_integration, format: :json)
