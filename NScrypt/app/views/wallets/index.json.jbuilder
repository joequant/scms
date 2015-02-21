json.array!(@wallets) do |wallet|
  json.extract! wallet, :id, :currency, :address, :user_id
  json.url wallet_url(wallet, format: :json)
end
