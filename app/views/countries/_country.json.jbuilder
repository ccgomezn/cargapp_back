json.extract! country, :id, :name, :code, :description, :cioc, :currency_code, :currency_name, :currency_symbol, :language_iso639, :language_name, :language_native_name, :image, :date_utc, :active, :created_at, :updated_at
json.url country_url(country, format: :json)
