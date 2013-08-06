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

$LOAD_PATH << File.expand_path(File.join(__dir__, './'))

class ReactionKinetics < Object
  
  require 'head_tail'
  require 'chem_species'
  
  attr_reader :pi_time_05
  attr_reader :pi_time_09999
  attr_reader :pi_time_grid
  attr_reader :pi_time_step
  
  attr_reader :product
  attr_reader :reactant
  attr_reader :reaction_coefficient
  
  HI_RES_PI_TIME_STEP = 0.1
  LOW_RES_PI_TIME_STEP = 1.0
    
  # 'pi_' prefix denotes a dimensionless quantity
  def initialize reaction_coefficient
    @product, @reactant = {}, {}
    
    @reaction_coefficient = reaction_coefficient
    
    @pi_time_05 = Math.log 2
    @pi_time_09999 = Math.log 10_000
    
    @pi_time_grid, @pi_reactant_evolution, @pi_product_evolution = [], [], []
    
    @pi_results = {}
  end
  
  def add_reactant chem_species
    raise NoChemSpeciesObjectError unless chem_species.is_a? ChemSpecies
    @reactant[chem_species.name] = [[chem_species.concentration]]
  end
  
  def add_product chem_species
    raise NoChemSpeciesObjectError unless chem_species.is_a? ChemSpecies
    @product[chem_species.name] = [[chem_species.concentration]]
  end
    
  def grid_pi_time
    low_res_grid, high_res_grid = [], []
    high_res_grid = (0...@pi_time_05).step(@pi_time_05 * \
      HI_RES_PI_TIME_STEP).to_a
    low_res_grid = (@pi_time_05..@pi_time_09999).step(@pi_time_05 * \
      LOW_RES_PI_TIME_STEP).to_a
    @pi_time_grid = high_res_grid + low_res_grid
  end
  
  def consume_using_pi_time_grid reactant_name
    @pi_time_grid.each do |pi_time|
      @pi_reactant_evolution << Math.exp(-pi_time)
    end
    @reactant[reactant_name] << @pi_reactant_evolution
    @reactant[reactant_name].tail.flatten
  end
  
  def yield_using_pi_time_grid product_name
    @pi_time_grid.each do |pi_time|
      @pi_product_evolution << 1.0 - Math.exp(-pi_time)
    end
    @product[product_name] << @pi_product_evolution
    @product[product_name].tail.flatten
  end
    
  def pi_results
    @pi_time_grid.each_index do |index|
      @pi_results[index] = [
        @pi_time_grid[index], 
        @pi_reactant_evolution[index], 
        @pi_product_evolution[index]
      ]
    end
    @pi_results
  end
      
  NoChemSpeciesObjectError = Class.new StandardError
  
end
