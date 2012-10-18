def quick_sort(list)
  if list.length() <= 1
    result = list
  else
#    pivotcandidates = [list[0],list[-1],list[list.length()/2]]
#    pivot = pivotcandidates.sort[1]
    pivot = list.pop()
    right, left = Array.new, Array.new
    for i in 0..list.length-1
      if list[i] < pivot
        left << list[i]
      elsif list[i] > pivot
        right << list[i]
      else
      end
    end
    result = [quick_sort(left)] + [pivot] + [quick_sort(right)]
    result = result.flatten
  end
  return result
end
