json.array!(@schedules) do |schedule|
  json.extract! schedule, :id, :sc_event_id, :timestamp, :argument, :recurrent, :status
  json.url schedule_url(schedule, format: :json)
end
