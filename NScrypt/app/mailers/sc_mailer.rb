class ScMailer < ApplicationMailer
  default from: "no-reply@crypto-law.com"

  def send_sc_email(to, cc, subject, body)
    @body = body
    mail(to: to, cc: cc, subject: subject)
  end
end
