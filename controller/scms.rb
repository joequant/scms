#!/usr/bin/env ruby

require 'sqlite3'
require './controller/repository'
require './controller/clerk'
require './controller/interpreter'
require './controller/executor'
require './controller/registrar'

class SCMS
  attr_reader :registrar, :clerk, :interpreter, :executor, :repo
  
  def initialize()
    @repo = Repository.new('./model/sc_repo.db')
    @registrar = Registrar.new(@repo)
    @executor = Executor.new
    @interpreter = Interpreter.new(@executor)
    @clerk = Clerk.new(@repo, @interpretor)
    @interpreter.assign_clerk(@clerk)
    
    @repo.load_persons
  end
  
  def login
  end
  
  def interpret(sc)
    @interpreter.interpret(sc)
  end
  
  def call_event(sc, event, args)
    @interpreter.interpret_event(sc, event, args)
  end
  
  def create_sc
  end
  
  def read_sc
  end
  
  def update_sc
  end
  
  def delete_sc
  end

  def create_person(name, pub_key, email)
  end
  
  def read_person
  end
  
  def update_person
  end
  
  def delete_person
  end
end

