class ContractNotifier < ApplicationMailer
  default from: "no-reply@crypto-law.com"

  def notify_proposal(code)
    @code = code
    @author = User.find(code.author)
    code.parties.each{ |p|
      if p.user.id != code.author
        @cp = p.user
        mail(to: @cp.email, subject: 'NScrypt -- New proposal')
      end
    }
  end
end
