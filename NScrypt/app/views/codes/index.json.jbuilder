json.array!(@codes) do |code|
  json.extract! code, :id, :version, :code, :contract_id, :state
  json.url code_url(code, format: :json)
end
