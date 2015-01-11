#!/usr/bin/env ruby

class Wallet
  attr_reader :wallet_id, :person, :currency, :sending_address, :receiving_address, :descr
  
  def initialize(wallet_id, person, currency, sending_address, receiving_address, descr)
    @wallet_id = wallet_id
    @person = person
    @currency = currency
    @sending_address = sending_address
    @receiving_address = receiving_address
    @descr = descr
  end
end
