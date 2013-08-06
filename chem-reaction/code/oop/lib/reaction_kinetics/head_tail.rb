#!/usr/local/bin/ruby
#--
# Have faith in the way things are.
#
# array.rb
# date: 2013.06.27
#++

# == Description
# open Array std class to add head and tail methods
#
# == Author
# rimbaud1854
#
# == Copyright
# Copyright (c) 2013 rimbaudcode
# Licensed under GPLv3+. No warranty provided.

class Array < Object
  
  def tail
    head, *tail = self
    tail
  end
  
  def head
    head, *tail = self
    head
  end
  
end


if $0 == __FILE__
  begin
    array = (0..10).to_a
    p array.head
    p array.tail
    exit
  rescue
    $stderr.puts "#{$!}"
    $@.each do |item| $stderr.puts item end
    abort
  ensure
    #
  end
end

