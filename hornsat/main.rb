require 'colorize'
require './parser'

puts "Input symbolic logic statements separated by commas:".blue
puts "Valid literals: A-Z"
puts "Valid Operators:"
puts "AND: ^ or &"
puts "OR: v or |"
puts "IFF: <-> or <>"
puts "IMPLIES: -> or <-"
puts "NESTING: () or []"
puts "NEGATION: ~ or !"
puts "Please enter your statement:"
input = Parser.new(gets.chomp)
input.solve
puts input.truth_table


