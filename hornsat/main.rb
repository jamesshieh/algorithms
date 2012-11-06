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

test = "((AvB)&(C&E))->(D&F),A,!B, A->C, D&E&F"

#input = Parser.new(gets.chomp)
input = Parser.new(test)
input.define_sub_problems
puts input.sub_problems


