json.extract! favorite_route, :id, :origin_city_id, :destination_city_id, :user_id, :active, :created_at, :updated_at
json.url favorite_route_url(favorite_route, format: :json)
