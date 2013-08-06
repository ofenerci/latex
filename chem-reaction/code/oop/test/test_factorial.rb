#!/usr/local/bin/ruby
#--
# Have faith in the way things are.
#
# test_factorial.rb
# date: 2013.06.25
#++

# == Description
# testing factorial.rb
#
# == Author
# rimbaud1854
#
# == Copyright
# Copyright (c) 2013 rimbaudcode
# Licensed under GPLv3+. No warranty provided.

require 'test/unit'
require 'test_unit_extensions'
require 'factorial'

class TestFactorial < Test::Unit::TestCase
    
  must 'return 3628800' do
    assert_equal(3628800, 10._!)
  end
  
  must 'not return 3628800' do
    assert_not_equal(3628800, 11._!)
  end
  
end
