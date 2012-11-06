require './string_validate'

# Tokenizer to prepare user input for lexer

class Tokenizer
  attr_accessor :statement_hash

  def initialize(x)
    @statement = regexp(x)
    @statement_hash = self.tokenize(@statement)
  end

  # Validate inputs and return error if invalid characters are passed.
  # Standardize characters for easier processing in lexer

  def regexp(raw)
    input = raw
    regexp = Regexp.new('\A[A-Zv\^\&\!\~\|\-\>\<\(\)\ \[\]\{\}\,\+]*\z')
    if input.validate(regexp)
      input.gsub!(/v/, "|")
      input.gsub!(/\^/, "&")
      input.gsub!(/\~/, "!")
      input.gsub!(/\-\>/, ">")
      input.gsub!(/\<\-/, "<")
      input.gsub!(/\[\{/, "(")
      input.gsub!(/\]\}/, ")")
      input.gsub!(/\<\-\>/, "+")
      input.gsub!(/\<\>/, "+")
      return input
    else
      raise "Invalid input. Only the characters \"A-Z ^ & v | ~ () [] {} < - >\" are allowed"
    end
  end

  # Validate grammar and syntax

  def grammar_valid?(statement)
    last = ""
    r1 = Regexp.new('[A-Z]')
    statement.each do |clauses|
      last = ""
      clauses.each do |word|
        if word.validate(r1) and last.validate(r1)
          raise "Invalid grammar"
        end
        last = word
      end
    end
  end

  # Tokenize the input into individual tokens

  def tokenize(raw)
    clausearr = []
    processed = []
    clauses = raw.split(",")
    clauses.each do |c|
      clausearr << c.scan(/\S/)
    end
    raise "Invalid input syntax" if !grammar_valid?(clausearr)
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
        nests[nl] << nl + 1
        nl += 1
        nests[nl] = [] if !nests.has_key?(nl)
      elsif k == ")"
        nests[nl] << ";"
        nl -= 1
      else
        nests[nl] << k
      end
    end
    return nests
  end

end
