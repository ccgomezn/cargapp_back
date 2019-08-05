json.extract! status, :id, :name, :code, :description, :user_id, :cargapp_model_id, :active, :created_at, :updated_at
json.url status_url(status, format: :json)
