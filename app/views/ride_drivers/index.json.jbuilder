json.array!(@ride_drivers) do |ride_driver|
  json.extract! ride_driver, :user_id, :ride_id
  json.url ride_driver_url(ride_driver, format: :json)
end
