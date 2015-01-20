json.array!(@sc_events) do |sc_event|
  json.extract! sc_event, :id
  json.url sc_event_url(sc_event, format: :json)
end
