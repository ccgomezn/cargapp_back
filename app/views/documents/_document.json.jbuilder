json.extract! document, :id, :document_id, :document_type_id, :file, :statu_id, :user_id, :expire_date, :approved, :active, :created_at, :updated_at
json.url document_url(document, format: :json)
