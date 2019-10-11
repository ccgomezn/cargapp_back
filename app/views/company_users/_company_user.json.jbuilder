json.extract! company_user, :id, :company_id, :user_id, :active, :created_at, :updated_at
json.url company_user_url(company_user, format: :json)
