class ScmsUser
  attr_reader :name, :email, :wallets

  def initialize(name, email, wallets)
    @name = name
    @email = email
    @wallets = wallets
  end

  def inspect
    @name
  end

end
