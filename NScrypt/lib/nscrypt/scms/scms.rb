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

  def send_email(to, cc, subject, body)
    @controller.send_sc_email(to, cc, subject, body)
  end

  def check_blockchain_for_transaction(sender, recipient, currency, amount, start_date = nil, end_date = nil)
    @controller.check_blockchain_for_transaction(sender, recipient, currency, amount, start_date, end_date)
  end

  def http_get(url)
    @controller.http_get(url)
  end

end

