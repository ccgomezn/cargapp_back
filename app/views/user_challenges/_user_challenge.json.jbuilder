json.extract! user_challenge, :id, :position, :point, :challenge_id, :user_id, :active, :created_at, :updated_at
json.url user_challenge_url(user_challenge, format: :json)
