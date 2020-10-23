json.extract! user_payment_method, :id, :email, :uuid, :token, :card_number, :expiration, :cvv, :observation, :user_id, :payment_method_id, :active, :created_at, :updated_at
json.url user_payment_method_url(user_payment_method, format: :json)
