class ContinuousSequence

  def initialize(list)
    @list = list
    @summed_array = self.summed_array
  end

  def summed_array
    sumar = Array.new
    for i in 0..@list.length-1
      sum = 0
      @list[0..i].each {|x| sum += x}
      sumar << sum
    end
    return sumar
  end

  def max_conseq
    max = 0
    maxpos = Array.new
    for i in 0..@summed_array.length-1
      for j in i+1..@summed_array.length-1
        if (@summed_array[i]-@summed_array[j]).abs > max
          max = (@summed_array[i]-@summed_array[j]).abs
          startindex = i
          endindex = j
        end
      end
    end
    print "The largest chain is #{max} which is the series #{@list[startindex+1..endindex+1]}"
  end
end
