json.array!(@events) do |event|
  json.extract! event, :name, :day, :start, :end, :location_id
  json.url event_url(event, format: :json)
end
