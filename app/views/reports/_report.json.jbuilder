json.extract! report, :id, :name, :origin, :destination, :cause, :sense, :novelty, :geolocation, :image, :start_date, :end_date, :report_type, :user_id, :active, :created_at, :updated_at
json.url report_url(report, format: :json)
