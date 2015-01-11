#!/usr/bin/env ruby

require './model/person'
require './model/wallet'
require './model/sc'
require './model/sc_event'

require 'net/smtp'

class Functions
  attr_reader :repo
  
  def initialize(repo)
    @repo = repo
  end

  def automate_payment(amount, currency, payor_wallet, payee_wallet)
    print "Automating payment: #{amount} #{currency} from '#{payor_wallet.nil? ? "self" : payor_wallet.descr}' to '#{payee_wallet.nil? ? "self" : payee_wallet.descr}'"
    deduct_payor(payor_wallet, amount)
    credit_payee(payee_wallet, amount)
  end
  
  def deduct_payor(wallet, amount)
    balance = get_wallet_balance(wallet)
    new_balance = balance - amount
    name = wallet.nil? ? "sc" : wallet.person.full_name[0..3].downcase.strip
    file = File.open("./etc/#{name}.wallet", "w")
    file.write("#{new_balance}")
    file.close
    print "Deducted #{amount} from #{name}"
  end

  def credit_payee(wallet, amount)
    balance = get_wallet_balance(wallet)
    new_balance = balance + amount
    name = wallet.nil? ? "sc" : wallet.person.full_name[0..3].downcase.strip
    file = File.open("./etc/#{name}.wallet", "w")
    file.write("#{new_balance}")
    file.close
    print "Credited #{amount} to #{name}"
  end

  def get_wallet_balance(wallet)
    name = wallet.nil? ? "sc" : wallet.person.full_name[0..3].downcase.strip
    file = File.open("./etc/#{name}.wallet")
    contents = file.read
    #print "#{name}'s wallet balance is #{contents}"
    contents.strip.to_i
  end

  def send_email(to_address, subject, body)
    print "Sending an email to #{to_address}\n Subject: #{subject}\n#{body}"
    message = <<MESSAGE_END
From: CryptoLaw-no-reply <no-rpely@cryptolaw.com>
To: A Test User <#{to_address}>
Subject: #{subject}

#{body}
MESSAGE_END

    Net::SMTP.start('localhost') do |smtp|
      smtp.send_message message, 'no-rpely@cryptolaw.com', to_address
    end
end

  def web_get(url)
    print "Getting from #{url}"
    {'Chelsea' => 2, 'Arsenal' => 1}
  end

  def web_post(url, body)
    print "Posting to #{url}\n#{body}"
  end

  def print(message)
    puts "SC: #{message}"
  end
end
