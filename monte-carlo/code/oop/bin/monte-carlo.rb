#!/usr/local/bin/ruby
#--
# Have faith in the way things are.
#
# monte-carlo.rb
# date: 2014.08.05
#++

# == Description
# Estimation of integrals by Monte-Carlo (integration)
#
# == File
# This file contains the main function
#
# == Author
# rimbaud1854
#
# == Copyright
# Copyright (c) 2014 rimbaudcode
# Licensed under GPLv3+. No warranty provided.

$LOAD_PATH << File.expand_path(File.join(__dir__, '../lib'))

def integrand x
  Math::exp(-x) * Math::sin(x)
end

def main args  
  require 'monte-carlo'
  
  tau         = 2.0 * Math::PI
  sample_size = 100_000
  interval    = (0.0..tau)
  monte       = MonteCarlo.new integrand(0.0), sample_size, interval
  
  monte.calculate_integrand_values
  monte.calculate_average_integrand
  monte.calculate_average_integral
  monte.calculate_uncertainty
  p monte.average_integral_uncertainty

  exit
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

