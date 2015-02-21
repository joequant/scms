json.array!(@sc_values) do |sc_value|
  json.extract! sc_value, :id, :contract_id, :key, :value
  json.url sc_value_url(sc_value, format: :json)
end
