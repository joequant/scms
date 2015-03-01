json.array!(@minutes) do |minute|
  json.extract! minute, :id, :contract_id, :user_id, :message, :when
  json.url minute_url(minute, format: :json)
end
