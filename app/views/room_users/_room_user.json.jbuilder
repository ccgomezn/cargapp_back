json.extract! room_user, :id, :service_id, :room_id, :user_id, :active, :created_at, :updated_at
json.url room_user_url(room_user, format: :json)
