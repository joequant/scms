class SC
  attr_reader :id

  def initialize(scms, contract)
    @scms = scms
    @contract = contract
    @id = @contract.id
    @status = @contract.status
  end

  def get_status
    @status
  end

end

