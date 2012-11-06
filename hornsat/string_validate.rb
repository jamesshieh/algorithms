# String extention to validate by regexp statement

class String
  def validate(regex)
    !self[regex].nil?
  end
end


