#!/usr/bin/env ruby

require './model/sc'
require './model/person'
require './model/wallet'
require './model/sc_event'

class Repository
  attr_reader :db, :scs, :persons
  
  def initialize(db_file)
    @db = SQLite3::Database.open(db_file)
    load_repo
  end
  
  def load_repo
    @scs = Hash.new
    @persons = Hash.new
    load_persons
    load_scs
  end
  
  def load_scs
    query_string = "SELECT sc_id, key, value FROM SC_Value"
    stm = @db.prepare(query_string)
    res = stm.execute
    values = Hash.new
    while result = res.next
      values[result[0]] = Hash.new if values[result[0]].nil?
      values[result[0]][result[1]] = result[2]
    end
    
    query_string = "SELECT sc_id, person_id, role FROM SC_Party"
    stm = @db.prepare(query_string)
    res = stm.execute
    parties = Hash.new
    while result = res.next
      parties[result[0]] = Hash.new if parties[result[0]].nil?
      parties[result[0]][result[2]] = @persons[result[1]]
    end
    
    query_string = "SELECT sc_id, event_time, callback, descr FROM SC_Event"
    stm = @db.prepare(query_string)
    res = stm.execute
    events = Hash.new
    while result = res.next
      events[result[0]] = {} if events[result[0]].nil?
      events[result[0]] << SCEvent.new(result[0], result[1], result[2], result[3])
    end
    
    query_string = "SELECT s.sc_id, s.pub_key, s.priv_key, s.status, c.code FROM SC s join SC_Code c on s.sc_id = c.sc_id"
    stm = @db.prepare(query_string)
    res = stm.execute
    while result = res.next
      @scs[result[0]] = SC.new(result[0], result[1], result[2], result[3], result[4], values[result[0]], parties[result[0]], events[result[0]], self)
    end
    #p @scs
  end
  
  def load_persons
    query_string = "SELECT person_id, full_name, pub_key, email FROM Person"
    stm = @db.prepare(query_string)
    p_res = stm.execute
    
    obj_res = Array.new
    while result = p_res.next
      @persons[result[0]] = Person.new(result[0], result[1], result[2], result[3], nil)
    end

    query_string = "SELECT wallet_id, person_id, currency, receiving_address, sending_address, descr FROM Wallet"
    stm = @db.prepare(query_string)
    w_res = stm.execute
    
    wallets = Hash.new
    while result = w_res.next
      wallets[result[1]] = {} if wallets[result[1]].nil?
      wallets[result[1]][result[2]] = [] if wallets[result[1]][result[2]].nil?
      wallets[result[1]][result[2]] << Wallet.new(result[0], @persons[result[1]], result[2], result[3], result[4], result[5])
    end
    
    @persons.each{|k, p| p.assign_wallets(wallets[p.person_id])}
    #p @persons
  end
  
  def create_sc
  end
  
  def read_sc
  end
  
  def update_sc
  end
  
  def delete_sc
  end
  
  def list_events
  end
  
  def set_sc_value(sc_id, key, value)
    value = "'#{value}'"
    query = "INSERT INTO SC_Value(sc_id, key, value) VALUES (#{sc_id}, '#{key}', #{value})"
    #puts query
    stm = @db.prepare(query)
    stm.execute
  end
  
  def set_sc_status(sc_id, status)
    query = "UPDATE SC SET status = '#{status}' WHERE sc_id = #{sc_id}"
    #puts query
    stm = @db.prepare(query)
    stm.execute
  end
end
