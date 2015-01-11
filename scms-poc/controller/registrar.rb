#!/usr/bin/env ruby

class Registrar
  attr_accessor :repo
  
  def initialize(repo)
    @repo = repo
  end
  
  def create_person(name, pub_key, email)
  end
  
  def read_person
  end
  
  def update_person
  end
  
  def delete_person
  end
  
  def login
  end
end
