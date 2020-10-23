json.extract! coupon, :id, :name, :code, :description, :is_porcentage, :value, :quantity, :cargapp_model_id, :user_id, :active, :created_at, :updated_at
json.url coupon_url(coupon, format: :json)
