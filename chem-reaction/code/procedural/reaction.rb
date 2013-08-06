#!/usr/local/bin/ruby
#--
# Have faith in the way things are.
#
# reaction.rb
# date: 2013.06.26
#++

# == Description
# model of a first order chemical reaction
#
# == Author
# rimbaud1854
#
# == Copyright
# Copyright (c) 2013 rimbaudcode
# Licensed under GPLv3+. No warranty provided.

require 'pp'

REACTION_COEFFICIENT = 0.1
INIT_REACTANT_CONC = 0.1
HIGH_RES_TIME_STEP = 0.1
LOW_RES_TIME_STEP = 1.0

# dl = dimensionless
dl_t_0_5 = Math.log 2
dl_t_0_9999 = Math.log 10_000

dl_duration = (0..dl_t_0_5).step(HIGH_RES_TIME_STEP * dl_t_0_5).to_a
dl_duration = dl_duration + (dl_t_0_5..dl_t_0_9999).step(LOW_RES_TIME_STEP * dl_t_0_5).to_a

dl_results = {}
dl_duration.each do |dl_t|
  dl_reactant_conc = Math.exp(-dl_t)
  dl_product_conc = 1.0 - dl_reactant_conc
  dl_results[dl_t] = [dl_reactant_conc, dl_product_conc]
end

pp dl_results
