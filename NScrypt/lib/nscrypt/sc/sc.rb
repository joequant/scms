class SC
  attr_reader :id

  def initialize(scms, contract)
    @scms = scms
    @contract = contract
    @id = @contract.id
  end

end

