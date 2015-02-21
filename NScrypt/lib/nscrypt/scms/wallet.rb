class ScmsWallet
  attr_reader :currency, :address

  def initialize(currency, address)
    @currency = currency
    @address = address
  end

  def inspect
    @address
  end

end
