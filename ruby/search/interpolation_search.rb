def interpolation_search(array, x)
  return -1 if x < array.first && x > array.last

  start  = 0
  finish = array.size - 1

  while start <= finish
    middle = start == finish ? start : start + (finish - start) * (x - array[start]) / (array[finish] - array[start])

    return -1 if middle < start || middle > finish

    if array[middle] < x
      start  = middle + 1
    elsif array[middle] > x
      finish = middle - 1
    else
      return middle
    end
  end

  return -1
end

# array = 100.times.map { rand(100) }.sort.uniq
# 100.times do
#   x = rand(100)
#   index = array.index(x) || -1
#   p [x, index, interpolation_search(array, x), array]
#   fail unless interpolation_search(array, x) == index
# end
