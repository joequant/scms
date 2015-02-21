class ScmsUser
  attr_reader :id, :name, :email, :wallets

  def initialize(id, name, email, wallets)
    @id = id
    @name = name
    @email = email
    @wallets = wallets
  end

  def inspect
    @name
  end

end
