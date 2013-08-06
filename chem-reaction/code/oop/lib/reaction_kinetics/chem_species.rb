#!/usr/local/bin/ruby
#--
# Have faith in the way things are.
#
# chem_species.rb
# date: 2013.06.26
#++

# == Description
# models chemical species
#
# == Author
# rimbaud1854
#
# == Copyright
# Copyright (c) 2013 rimbaudcode
# Licensed under GPLv3+. No warranty provided.

class ChemSpecies < Object
  
  attr_reader :name
  attr_reader :concentration
  attr_accessor :concentration_evolution
  
  def initialize name, concentration
    @name = name
    @concentration = concentration
  end
  
end


if $0 == __FILE__
  begin
    hydrogen = ChemSpecies.new 'H2', 0.1
    p hydrogen
    p hydrogen.name
    p hydrogen.concentration

    a = ChemSpecies.new 'a', 0.2
    p a
    
    exit
  rescue
    $stderr.puts "#{$!}"
    $@.each do |item| $stderr.puts item end
    abort
  ensure
    #
  end
end
