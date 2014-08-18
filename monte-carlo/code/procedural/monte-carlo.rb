#!/usr/local/bin/ruby
#--
# Have faith in the way things are.
#
# monte-carlo.rb
# date: 2014.08.05
#++

# == Description
# Estimate integral: int{exp(-x)sin(x) dx}{0 to tau} by Monte-Carlo
#
# == Third-party libs
# The code depends on the 'descriptive_statistics' gem. To install it
# $ gem install 'descriptive_statistics'
#
# == Algorithm
# define the integrand
# define the sample size = n
# for every n
#   randomly choose n points within [0, tau], 
#   use them to calculate values for the integrand
#   store the values in an array
# calculate the function average value from the array
# calculate the function integral value
# calculate the uncertainty
# print results
#
# == Author
# rimbaud1854
#
# == Copyright
# Copyright (c) 2014 rimbaudcode
# Licensed under GPLv3+. No warranty provided.

def integrand x
  exp(-x) * sin(x)
end

def main args
  include Math
  require 'descriptive_statistics'

  tau         = 2.0 * PI
  sample_size = 100_000

  low_bound = 0.0
  up_bound  = tau
  interval  = (low_bound..up_bound)

  function_values = []
  sample_size.times do 
      random_point = rand interval
      function_values << integrand(random_point)
    end

  average_function = function_values.mean
  average_integral = (up_bound - low_bound) * average_function
  uncertainty      = function_values.standard_deviation / sqrt(sample_size)
  result           = [average_integral, uncertainty]

  p result
  
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

