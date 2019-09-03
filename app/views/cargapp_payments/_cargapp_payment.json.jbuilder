json.extract! cargapp_payment, :id, :uuid, :amount, :transaction_code, :observation, :payment_method_id, :statu_id, :generator_id, :receiver_id, :bank_account_id, :service_id, :company_id, :user_id, :active, :created_at, :updated_at
json.url cargapp_payment_url(cargapp_payment, format: :json)
