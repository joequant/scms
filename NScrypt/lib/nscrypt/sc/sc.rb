require_relative './party.rb'
require_relative './record.rb'
require_relative '../scms/user.rb'
require_relative '../scms/wallet.rb'

class SC
  def initialize(scms, controller)
    @scms = scms
    @controller = controller
  end

  def inspect
    id
  end

  def id
    @controller.get_sc_id
  end

  def status
    @controller.get_sc_status
  end

  def set_status(status)
    @controller.set_sc_status(status)
  end

  def note(message)
    @controller.add_sc_note(message)
  end

  def notes
    @controller.get_sc_notes
  end

  def source
    @controller.get_sc_source
  end

  def records
    result = @controller.get_sc_values
    vals = Hash.new
    result.each{ |v| vals[v.key] = v.value }
    vals
  end

  def set_record(key, value)
    @controller.set_sc_value(key, value)
  end

  def parties
    result = @controller.get_sc_parties
    ps = Hash.new
    result[:parties].each{ |p|
      w = Array.new
      result[:wallets][p.user].each{ |r| w << ScmsWallet.new(r.currency, r.address) }
      ps[p.role.name] = ScmsUser.new(p.user.name, p.user.email, w)
    }
    ps
  end

  def current_user_is(role)
    @controller.is_sc_party(role)
  end

end

