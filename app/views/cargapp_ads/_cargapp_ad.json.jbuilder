json.extract! cargapp_ad, :id, :name, :price, :description, :body, :image, :url, :media, :have_discoun, :is_percentage, :discoun, :user_id, :active, :created_at, :updated_at
json.url cargapp_ad_url(cargapp_ad, format: :json)
