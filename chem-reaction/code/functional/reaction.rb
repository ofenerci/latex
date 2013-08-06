#!/usr/local/bin/ruby
#--
# Have faith in the way things are.
#
# reaction.rb
# date: 2013.06.26
#++

# == Description
# batch reactor first-order chemical reaction model
#
# == Author
# rimbaud1854
#
# == Copyright
# Copyright (c) 2013 rimbaudcode
# Licensed under GPLv3+. No warranty provided.

require 'json'
require 'pp'

REACTION_COEFFICIENT = 0.1
INIT_REACTANT_CONC = 0.1
HIGH_RES_TIME_STEP = 0.1
LOW_RES_TIME_STEP = 1.0

def main args
  t_0_5 = calculate_t_0_5
  t_0_9999 = calculate_t_0_9999
  time_grid = discretize_time t_0_5, t_0_9999
  concentrations = calculate_concentrations time_grid
  pp concentrations
  #print JSON.pretty_generate concentrations
  #p product_evolution concentrations
  #p reactant_evolution concentrations
  exit
end

# calculate _dimensionless_ half-life time of the reactant or product
def calculate_t_0_5
  Math.log 2
end

# calculate _dimensionless_ 99.99%-life time of the reactant or product
def calculate_t_0_9999
  Math.log 10_000
end

# discretize _dimensionless_ time
# input:  _dimensionless_ half-life time
#         _dimensionless_ 99.99%-life time
# output: _dimensionless_ time grid array
def discretize_time t_0_5, t_0_9999
  (0..t_0_5).step(HIGH_RES_TIME_STEP * t_0_5).to_a + 
  (t_0_5..t_0_9999).step(LOW_RES_TIME_STEP * t_0_5).to_a
end

# calculate _dimensionless_ reactant and product concentrations
# input:  _dimensionless_ time grid
# output: concentrations dictionary: 
#         keys:   _dimensionless_ time
#         values: _dimensionless_ reactant and product concentrations
def calculate_concentrations time_grid
  results = {}
  time_grid.each do |time|
    reactant_conc = Math.exp(-time)
    product_conc = 1.0 - reactant_conc
    results[time] = [reactant_conc, product_conc]
  end
  results
end

def product_evolution concentrations
  product_evolution = []
  concentrations.each_key do |key| 
    product_evolution << concentrations[key][1]
  end
  product_evolution
end

def reactant_evolution concentrations
  reactant_evolution = []
  concentrations.each_key do |key| 
    reactant_evolution << concentrations[key][0]
  end
  reactant_evolution
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
