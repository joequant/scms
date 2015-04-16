json.array!(@reputations) do |reputation|
  json.extract! reputation, :id, :user_id, :contract_id, :category, :subcategory, :item, :params, :status
  json.url reputation_url(reputation, format: :json)
end
