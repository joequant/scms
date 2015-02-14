json.array!(@sc_event_runs) do |sc_event_run|
  json.extract! sc_event_run, :id, :sc_event_id, :run_at, :result
  json.url sc_event_run_url(sc_event_run, format: :json)
end
