json.extract! company, :id, :name, :description, :company_type, :load_type_id, :sector, :legal_representative, :address, :phone, :user_id, :constitution_date, :active, :created_at, :updated_at
json.url company_url(company, format: :json)
