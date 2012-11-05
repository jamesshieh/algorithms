require './string_validate'

# Tokenizer to prepare user input for lexer

class Tokenizer
  attr_accessor :statement_hash

  def initialize(x)
    @statement = regexp(x)
    @statement_hash = self.tokenize
  end

  # Validate inputs and return error if invalid characters are passed.
  # Standardize characters for easier processing in lexer

  def regexp(x)
    regex = Regexp.new('\A[A-Zv\^\&\!\~\|\-\>\<\(\)\ \[\]\{\}\,]*\z')
    if x.validate(regex)
      x.gsub(/v/, "|")
      x.gsub(/\^/, "&")
      x.gsub(/\~/, "!")
      x.gsub(/->/, ">")
      x.gsub(/<-/, "<")
      x.gsub(/\[\{/, "(")
      x.gsub(/\]\}/, ")")
      return x
    else
      puts "Invalid input. Only the characters \"A-Z ^ & v | ~ () [] {}\" are allowed"
    end
  end

  # Tokenize the input into individual tokens

  def tokenize
    clausearr = []
    processed = []
    clauses = @statement.split(",")
    clauses.each do |c|
      clausearr << c.split(/\s*/)
    end
    clausearr.each do |carr|
      processed << process_parens(carr)
    end
    return processed
  end

  # Process parantheses and create hash table of nesting levels

  def process_parens(carr)
    nl = 0
    nests = {}
    nests[0] = []
    carr.each do |k|
      if k == "("
        nests[nl] << k
        nests[nl] << nl + 1
        nl += 1
        nests[nl] = [] if !nests.has_key?(nl)
      elsif k == ")"
        nests[nl] << ";"
        nl -= 1
        nests[nl] << k
      else
        nests[nl] << k
      end
    end
    return nests
  end

end
