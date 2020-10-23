json.extract! room, :id, :name, :note, :service_id, :user_id, :active, :created_at, :updated_at
json.url room_url(room, format: :json)
