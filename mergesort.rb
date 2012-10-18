def merge(left,right)
  result = []
  while left.length > 0 or right.length > 0
    if left.length >0 and right.length >0
      if left[0] <= right[0]
        result << left.shift
      else
        result << right.shift
      end
    elsif left.length > 0
      result << left.shift
    elsif right.length > 0
      result << right.shift
    end
  end
  return result
end


def merge_sort(list)
  if list.length() <= 1
    return list
  else
    right = Array.new
    left = Array.new
    mid = list.length() / 2
    for i in 0..list.length-1
      left << list[i] if i < mid
      right << list[i] if i >= mid
    end
    left = merge_sort(left)
    right = merge_sort(right)
  end
  return merge(left,right)
end

