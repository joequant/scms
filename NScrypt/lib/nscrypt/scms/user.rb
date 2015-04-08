class ScmsUser
  attr_reader :id, :name, :email, :wallets

  def initialize(id, name, email, wallets)
    @id = id
    @name = name
    @email = email
    @wallets = wallets
  end

  def ==(another_user)
    self.id == another_user.id
  end

  def eql?(another_user)
    self.id == another_user.id
  end

  def hash
    @id.hash
  end
end
