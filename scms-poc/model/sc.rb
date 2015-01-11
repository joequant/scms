#!/usr/bin/env ruby

class SC
  attr_accessor :repo
  attr_reader :sc_id, :pub_key, :priv_key, :status, :code, :values, :parties, :events
  
  def initialize(sc_id, pub_key, priv_key, status, code, values, parties, events, repo)
    @sc_id = sc_id
    @pub_key = pub_key
    @priv_key = priv_key
    @status = 'draft'
    @code = code
    @values = values.nil? ? Hash.new : values
    @parties = parties.nil? ? Hash.new : parties
    @events = events.nil? ? Hash.new : events
    @@repo = repo if !repo.nil?
  end
  
  def set_status(status)
    @status = status
    @@repo.set_sc_status(@sc_id, @status)
  end
  
  def amend(code)
    @code = code
    @@repo.set_sc_code(@sc_id, @code)
  end
  
  def get_value(key)
    @values[key]
  end
  
  def set_value(key, value = nil)
    @values[key] = value
    @@repo.set_sc_value(@sc_id, key, value)
  end
  
  def add_party(person, role)
  end
  
  def remove_party(person)
  end
  
  def add_event(sc_event)
  end
  
  def list_events()
    :events
  end
  
  def remove_event(sc_event)
  end
  
  def delete
    @@repo.delete_sc(@sc_id)
  end
end
