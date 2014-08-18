#!/usr/local/bin/ruby
#--
# Have faith in the way things are.
#
# monte-carlo.rb
# date: 2014.08.05
#++

# == Description
# Class to model Monte-Carlo integration
#
# == Third-party libs
# The code depends on the 'descriptive_statistics' gem:
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

class MonteCarlo < Object
  
  require 'descriptive_statistics'
  
  def initialize integrand, sample_size, interval
    @integrand   = integrand
    @sample_size = sample_size
    @interval    = interval
  end
  
  def calculate_integrand_values
    @integrand_values = []
    
    @sample_size.times do 
      @integrand_values << integrand(rand @interval)
    end
  end
  
  def calculate_average_integrand
    @average_integrand = @integrand_values.mean
  end
  
  def calculate_average_integral
    @average_integral = (@interval.last - @interval.first) * @average_integrand
  end
  
  def calculate_uncertainty
    @uncertainty = @integrand_values.standard_deviation / Math::sqrt(@sample_size)
  end
  
  def average_integral_uncertainty
    [@average_integral, @uncertainty]
  end
  
end

