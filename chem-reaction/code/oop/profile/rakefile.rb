#!/usr/local/bin/ruby
#--
# Have faith in the way things are.
#
# rakefile.rb
# date: 2013.06.25
#++

# == Description
# profiling factorial.rb (bin)
#
# == Author
# rimbaud1854
#
# == Copyright
# Copyright (c) 2013 rimbaudcode
# Licensed under GPLv3+. No warranty provided.

require 'rake/clean'

SOURCE = '../bin/reaction_kinetics.rb'
ARGUMENTS = '10'
OUTPUT = 'prof_' + "#{File.basename SOURCE}"

PROFILER = `which ruby-prof`.chomp
PROF_FLAGS = '--mode=wall --printer=dot'

GRAPHER = `which dot`.chomp
GRAPHER_FLAGS = '-T pdf -o'

DEFAULT_TASKS = [
  :sanity_checks,
  :run_profiler,
  :run_grapher,
  :open_results
  ]

desc 'sanity checks'
task :sanity_checks do
  raise NoRubyProfInstalled unless File.exists? File.expand_path PROFILER
  raise NoDotInstalled unless File.exists? File.expand_path GRAPHER
end

task :default => DEFAULT_TASKS

desc 'run profiler'
task :run_profiler do
  sh "#{PROFILER} #{PROF_FLAGS} --file=#{OUTPUT}.dot #{SOURCE} #{ARGUMENTS}"
end

desc 'run grapher'
task :run_grapher do
  sh "#{GRAPHER} #{GRAPHER_FLAGS}  #{OUTPUT}.pdf #{OUTPUT}.dot"
end

desc 'open results file'
task :open_results do
  sh "open #{OUTPUT}.pdf"
end

CLEAN.include('*.dot')
CLOBBER.include('*.pdf')

NoRubyProfInstalled = Class.new StandardError
NoDotInstalled = Class.new StandardError
