require './lexer'

# Parser for logic statements

class Parser

  def initialize(input)
    lexicon = Lexer.new(input)
    @statement = lexicon.statement
    @truth_table = lexicon.truth_table
  end

  def symb_and
  end

  def symb_or
  end



end
