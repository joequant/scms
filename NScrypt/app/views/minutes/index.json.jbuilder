json.array!(@minutes) do |minute|
  json.extract! minute, :id, :message, :contract_id
  json.url minute_url(minute, format: :json)
end
