class SC
  def initialize(scms, controller)
    @scms = scms
    @controller = controller
  end

  def get_id
    @controller.get_sc_id
  end

  def get_status
    @controller.get_sc_status
  end

  def set_status(status)
    @controller.set_sc_status(status)
  end

  def note(message)
    @controller.add_sc_note(message)
  end

  def get_notes
    @controller.get_sc_notes
  end

  def get_source
    @controller.get_sc_source
  end

  def get_value(key)
    @controller.get_sc_value(key)
  end

  def set_value(key, value)
    @controller.set_sc_value(key, value)
  end

end

