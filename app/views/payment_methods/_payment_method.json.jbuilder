json.extract! payment_method, :id, :name, :uuid, :description, :email, :aap_id, :secret_id, :token, :password, :user_id, :active, :created_at, :updated_at
json.url payment_method_url(payment_method, format: :json)
