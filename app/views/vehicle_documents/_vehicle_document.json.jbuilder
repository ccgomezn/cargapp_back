json.extract! vehicle_document, :id, :document_type_id, :file, :statu_id, :user_id, :vehicle_id, :expire_date, :approved, :active, :created_at, :updated_at
json.url vehicle_document_url(vehicle_document, format: :json)
