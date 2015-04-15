json.array!(@rights) do |right|
  json.extract! right, :id, :user_id, :contract_id, :name, :subsists
  json.url right_url(right, format: :json)
end
