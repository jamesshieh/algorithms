require './lexer'

# Parser for logic statements

class Parser
  attr_accessor :truth_table
  
  def initialize(input)
    lexicon = Lexer.new(input)
    @statement_hash = lexicon.statement_hash
    @truth_table = lexicon.truth_table
    @sub_problems = {}
  end

  def define_sub_problems
    
  end

  def set_givens
    @statement_hash.each do |clause|
      if clause[0].length < 3
        given = ""
        clause[0].each do |word|
          given = word if word.validate(/[A-Z]/)
        end
        truth = !clause[0][0].validate(/[\!]/)
        set_fact(given, truth)
      end
    end
  end

  def solve
    self.set_givens
    @statement_hash.each do |clause| # clauses broken out
      max = clause.values.max # max nesting level evaluates first
      while max > 0
        sub_problem = clause[max]
        if sub_problem.length < 3
        end
      end     
    end
  end

  def truth?(id)
    return @truth_table[id]
  end

  def set_fact(given, truth)
    @truth_table[given] = truth
  end

end
