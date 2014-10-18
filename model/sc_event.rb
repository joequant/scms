#!/usr/bin/env ruby

class SCEvent
  attr_reader :sc_id, :time, :callback, :descr
  
  def initialize(sc_id, time, callback, descr)
    @sc_id = sc_id
    @time = time
    @callback = callback
    @descr = descr
  end
end
