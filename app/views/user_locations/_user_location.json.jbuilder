json.extract! user_location, :id, :longitude, :latitude, :city_id, :user_id, :active, :created_at, :updated_at
json.url user_location_url(user_location, format: :json)
