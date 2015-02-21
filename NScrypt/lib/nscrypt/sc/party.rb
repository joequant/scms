class ScParty
  attr_reader :role, :user

  def initialize(role, user)
    @role = role
    @user = user
  end

  def inspect
    @role
  end
end
