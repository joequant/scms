json.array!(@parties) do |party|
  json.extract! party, :id, :person_id, :contract_id, :role_id
  json.url party_url(party, format: :json)
end
