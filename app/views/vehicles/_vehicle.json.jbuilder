json.extract! vehicle, :id, :brand, :model, :model_year, :color, :plate, :chassis, :owner_vehicle, :vehicle_type_id, :owner_document_type_id, :owner_document_id, :user_id, :active, :created_at, :updated_at
json.url vehicle_url(vehicle, format: :json)
