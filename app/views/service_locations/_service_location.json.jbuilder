json.extract! service_location, :id, :longitude, :latitude, :city_id, :user_id, :service_id, :active, :created_at, :updated_at
json.url service_location_url(service_location, format: :json)
