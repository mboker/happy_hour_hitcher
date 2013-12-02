json.array!(@rides) do |ride|
  json.extract! ride, :event_id, :day, :time, :seats
  json.url ride_url(ride, format: :json)
end
