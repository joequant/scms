class SCMS

  def initialize(controller)
    @controller = controller
  end

  def print(message)
    logger.info(message)
  end

  def datetime_now
    Time.now
  end

  def current_user
    @controller.get_current_user
  end

  def send_email(to, cc, subject, body)
    @controller.send_sc_email(to, cc, subject, body)
  end

  def check_blockchain_for_transaction(sender, recipient, currency, amount, start_date = nil, end_date = nil)
    @controller.check_blockchain_for_transaction(sender, recipient, currency, amount, start_date, end_date)
  end

  def generate_url_to_event(event)
    @controller.url_to(event)
  end

  def http_get(url)
    @controller.http_get(url)
  end

end

