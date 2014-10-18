#!/usr/bin/env ruby

require './model/person'
require './model/wallet'
require './model/sc'
require './model/sc_event'
require './controller/interpreter/functions'

class SCFunctions
  attr_reader :sc, :repo
  
  def initialize(sc, repo)
    @sc = sc
    @repo = repo
  end

  def get_party(role)
    @sc.parties[role]
  end

  def key_exists(key)
    ! @sc.values[key].nil?
  end

  def get_value(key)
    @sc.value[key]
  end

  def set_value(key, value = nil)
    @sc.set_value(key, value)
  end

  def get_status()
    @sc.status
  end

  def set_status(status)
    @sc.set_status(status)
  end
end
