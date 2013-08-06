#!/usr/local/bin/ruby
#--
# Have faith in the way things are.
#
# rakefile.rb
# current v.: 0.0.2
# date: 2013.06.27
#++

# == Description
# building instructions for PHP pChart examples
#
# == Author
# rimbaud1854
#
# == Copyright
# Copyright (c) 2013 rimbaudcode
# Licensed under GPLv3+. No warranty provided.

require 'rake/clean'

FILE_LIST = Dir['*.php']

PICS_FOLDER = './pictures'

COMPILER = `which php`.chomp
FLAGS = '-q'

DEFAULT_TASKS = [
  :sanity_checks,
  :mk_pics_folder,
  :build_graphs
  ]

desc 'sanity checks'
task :sanity_checks do
  raise NoPHPInstalledError unless File.exists? File.expand_path COMPILER
end

desc 'compile and link sources'
task :default => DEFAULT_TASKS

desc 'make pictures folder'
task :mk_pics_folder do
  `mkdir -p #{PICS_FOLDER}`
end

desc 'compile source files into object files'
task :build_graphs do
  FILE_LIST.each do |file| 
    `#{COMPILER} #{FLAGS} #{file}`
  end
end

CLEAN.include("./#{PICS_FOLDER}/*.*")

NoPHPInstalledError = Class.new StandardError
