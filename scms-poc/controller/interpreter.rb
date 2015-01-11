#!/usr/bin/env ruby

class Interpreter
  attr_reader :clerk, :executor, :active_executor
  
  def initialize(executor)
    @executor = executor
  end
  
  def assign_clerk(clerk)
    @clerk = clerk
  end
  
  def interpret(sc, event = nil, args = [])
    #@executor.exec_mode = exec_mode
    arg_str = format_args(args) if !args.nil?
    script = <<SCRIPT
require './controller/interpreter/includes'
$fct = Functions.new(clerk.repo)
$sc_fct = SCFunctions.new(sc, clerk.repo)
#{sc.code}
#{event.nil? ? '' : event} #{event.nil? || args.nil? || args == [] ? '' : arg_str}
SCRIPT
    puts "DEMO: The SC Code is:\n#{script}"
    eval(script)
  end
  
  def format_args(args)
    #p args
    arg_str = args.collect{|s| s = '"' + s + '"'}.join(", ")
    puts arg_str
    arg_str
  end
end
