json.array!(@codes) do |code|
  json.extract! code, :id, :version, :code
  json.url code_url(code, format: :json)
end
