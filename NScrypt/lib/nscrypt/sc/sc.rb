require_relative './party.rb'
require_relative '../scms/user.rb'
require_relative '../scms/wallet.rb'

class SC
  attr_reader :id, :status, :records, :parties, :notes

  def initialize(controller, id, status, records, parties, notes)
    @controller = controller
    @id = id
    @status = status
    @records = records
    @parties = parties
    @notes = notes
  end

  def inspect
    {'id' => @id, 'status' => @status}
  end

  def update
    @status = @controller.get_sc_status
    @records = @controller.get_sc_values
    @parties = @controller.get_sc_parties
    @notes = @controller.get_sc_notes
  end

  def set_status(status)
    @controller.set_sc_status(status)
    @status = @controller.get_sc_status
  end

  def note(message)
    @controller.add_sc_note(message)
    @notes = @controller.get_sc_notes
  end

  def set_record(key, value)
    @controller.set_sc_value(key, value)
    @records = @controller.get_sc_values
  end

  def current_user?(role)
    @parties[role].id == @controller.get_current_user_id
  end

end
