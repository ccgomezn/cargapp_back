json.extract! service_user, :id, :service_id, :user_id, :position, :approved, :expiration_date, :active, :created_at, :updated_at
json.url service_user_url(service_user, format: :json)
