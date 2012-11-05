require './tokenizer'
require './string_validate'

class Lexer
  attr_accessor :statement :truth_table

  def initialize(input)
    @tokenizer = Tokenizer.new(input)
    @statement = @tokenizer.statement_hash
    @truth_table = self.create_truth_table(input)
  end

  def create_truth_table(input_string)
    variables = {}
    key = input_string.split(/\s*/)
    key.each do |k|
      variables[k] = false if k.validate(/[A-Z]/)
    end
    return variables
  end

end

