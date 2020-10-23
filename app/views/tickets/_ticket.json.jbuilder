json.extract! ticket, :id, :title, :body, :image, :media, :statu_id, :user_id, :active, :created_at, :updated_at
json.url ticket_url(ticket, format: :json)
