json.extract! user_prize, :id, :point, :prize_id, :expire_date, :user_id, :active, :created_at, :updated_at
json.url user_prize_url(user_prize, format: :json)
