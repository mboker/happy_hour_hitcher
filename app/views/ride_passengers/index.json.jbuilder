json.array!(@ride_passengers) do |ride_passenger|
  json.extract! ride_passenger, :user_id, :ride_id
  json.url ride_passenger_url(ride_passenger, format: :json)
end
