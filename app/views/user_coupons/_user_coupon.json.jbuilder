json.extract! user_coupon, :id, :discount, :cargapp_model_id, :applied_item_id, :coupon_id, :user_id, :active, :created_at, :updated_at
json.url user_coupon_url(user_coupon, format: :json)
