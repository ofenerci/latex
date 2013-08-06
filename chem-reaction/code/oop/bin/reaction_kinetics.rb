#!/usr/local/bin/ruby
#--
# Have faith in the way things are.
#
# reaction_kinetics.rb
# date: 2013.06.26
#++

# == Description
# models a first-order reaction kinetics
#
# == Author
# rimbaud1854
#
# == Copyright
# Copyright (c) 2013 rimbaudcode
# Licensed under GPLv3+. No warranty provided.

$LOAD_PATH << File.expand_path(File.join(__dir__, '../lib'))

require 'reaction_kinetics'

def main args
  require 'json'
  require 'pp'
  
  results_file = '../result/results.json'
  
  reactant = ChemSpecies.new 'R', 0.1
  product = ChemSpecies.new 'P', 0.0
      
  reaction_coefficient = 0.1
  reaction = ReactionKinetics.new reaction_coefficient
  
  reaction.add_reactant reactant
  reaction.add_product product
  
  # 'pi_' prefix means dimensionless
  reaction.grid_pi_time
  reaction.consume_using_pi_time_grid 'R'
  reaction.yield_using_pi_time_grid 'P'
  
  results = reaction.pi_results
  
  pp results
  write_to_json results, results_file
  
  exit
end

def write_to_json object, file
  File.open file, 'w' do |file| 
    file.write JSON.pretty_generate object#.to_json
  end
end


if $0 == __FILE__
  begin
    exit main $*
  rescue
    $stderr.puts "#{$!}"
    $@.each do |item| $stderr.puts item end
    abort
  ensure
    #
  end
end
