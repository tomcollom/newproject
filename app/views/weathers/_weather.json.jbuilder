json.extract! weather, :id, :city, :date, :time, :temperature, :description, :windspeed, :created_at, :updated_at
json.url weather_url(weather, format: :json)
