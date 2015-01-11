#!/usr/bin/env ruby

require './model/wallet'

class Person
  attr_reader :person_id, :full_name, :pub_key, :email, :wallets
  
  def initialize(person_id, full_name, pub_key, email, wallets)
    @person_id = person_id
    @full_name = full_name
    @pub_key = pub_key
    @email = email
    @wallets = wallets
  end
  
  def assign_wallets(wallets)
    @wallets = wallets
  end
end
