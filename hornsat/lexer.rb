require './tokenizer'
require './string_validate'

class Lexer
  attr_accessor :statement_hash, :truth_table

  def initialize(input)
    @tokenizer = Tokenizer.new(input)
    @statement_hash = @tokenizer.statement_hash
    @key = input.scan(/\S/)
    @truth_table = self.create_truth_table(@key)
    @lexeme_table = self.create_lexeme_table(@key)
  end

  def create_lexeme_table(key)
    lexemes = {
      "|"=>"|",
      "&"=>"&",
      "!"=>"!",
      "("=>"(", 
      ")"=>")",
      "+"=>"+", 
      "<"=>"<",
      ">"=>">"
    }
    key.each do |k|
      lexemes[k] = "id" if k.validate(/[A-Z]/) and !lexemes.has_key?(k)
    end
    return lexemes
  end
      

  def create_truth_table(key)
    variables = {}
    key.each do |k|
      variables[k] = false if k.validate(/[A-Z]/) and !variables.has_key?(k)
    end
    return variables
  end

end

