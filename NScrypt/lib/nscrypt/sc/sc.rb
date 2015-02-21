class SC
  attr_reader :id

  def initialize(scms, controller, contract)
    @scms = scms
    @controller = controller
    @contract = contract
    @id = @contract.id
    @status = @contract.status
  end

  def get_status
    @status
  end

  def note(message)
    @controller.add_note(message)
  end

end

