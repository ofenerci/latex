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
# == Algorithm
# define the sample size = n
# randomly choose n points within [0, tau], use them to calculate f(x) 
# and store the f(x)s in an array
# estimate the function average value
# estimate the function integral value
# estimate the uncertainty
#
# == Author
# rimbaud1854
#
# == Copyright
# Copyright (c) 2014 rimbaudcode
# Licensed under GPLv3+. No warranty provided.

include Math
require 'descriptive_statistics'

sample_size = 100_000
tau         = 2.0 * PI

low_bound = 0.0
up_bound  = tau
interval  = (low_bound..up_bound)

function_values = []
sample_size.times do 
    random_point = rand interval
    function_values << (exp(-random_point) * sin(random_point))
  end

average_function = function_values.mean
average_integral = (up_bound - low_bound) * average_function
uncertainty      = function_values.standard_deviation / sqrt(sample_size)
result           = [average_integral, uncertainty]

p result

