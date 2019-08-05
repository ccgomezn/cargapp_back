json.extract! state, :id, :name, :code, :description, :country_id, :active, :created_at, :updated_at
json.url state_url(state, format: :json)
