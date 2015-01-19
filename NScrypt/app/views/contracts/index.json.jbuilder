json.array!(@contracts) do |contract|
  json.extract! contract, :id, :title, :description
  json.url contract_url(contract, format: :json)
end
