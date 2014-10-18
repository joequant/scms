#!/usr/bin/env ruby

class Clerk
  attr_reader :repo, :interpreter, :events
  
  def initialize(repo, interpreter)
    @repo = repo
    @interpreter = interpreter
    @events = repo.list_events
    @events.each{|e| set_timer(e)} if ! @events.nil?
  end
  
  def set_timer(event)
  end
  
  def timer_event(sc, callback)
  end
  
  def interpret_only(sc, exec_mode)
    @interpreter.interpret(sc, exec_mode)
  end
end
