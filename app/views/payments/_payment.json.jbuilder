json.extract! payment, :id, :uuid, :total, :sub_total, :taxes, :transaction_code, :observation, :coupon_id, :coupon_code, :coupon_amount, :user_payment_method_id, :payment_method_id, :statu_id, :service_id, :is_service, :user_id, :active, :created_at, :updated_at
json.url payment_url(payment, format: :json)
