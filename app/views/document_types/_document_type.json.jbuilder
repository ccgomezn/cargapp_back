json.extract! document_type, :id, :name, :code, :description, :active, :created_at, :updated_at
json.url document_type_url(document_type, format: :json)
