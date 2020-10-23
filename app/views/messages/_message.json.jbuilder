json.extract! message, :id, :room_id, :message_type, :uuid, :message, :file, :user_id, :active, :created_at, :updated_at
json.url message_url(message, format: :json)
