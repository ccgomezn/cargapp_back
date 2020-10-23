json.extract! service_document, :id, :name, :document_type, :document, :service_id, :user_id, :active, :created_at, :updated_at
json.url service_document_url(service_document, format: :json)
