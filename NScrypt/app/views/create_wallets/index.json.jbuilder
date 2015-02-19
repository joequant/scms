json.array!(@create_wallets) do |create_wallet|
  json.extract! create_wallet, :id, :currency, :address, :user_id
  json.url create_wallet_url(create_wallet, format: :json)
end
