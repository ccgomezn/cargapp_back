json.extract! bank_account, :id, :account_number, :account_type, :bank, :user_id, :statu_id, :active, :created_at, :updated_at
json.url bank_account_url(bank_account, format: :json)
