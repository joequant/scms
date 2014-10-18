#!/usr/bin/env ruby

require "./controller/scms"

scms = SCMS.new

sc = scms.repo.scs[ARGV.shift.to_i]
event = ARGV.shift
args = ARGV
#p sc

scms.interpreter.interpret(sc, event, args)
