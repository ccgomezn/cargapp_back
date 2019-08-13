json.extract! profile, :id, :firt_name, :last_name, :avatar, :phone, :document_id, :document_type_id, :user_id, :birth_date, :created_at, :updated_at
json.url profile_url(profile, format: :json)
