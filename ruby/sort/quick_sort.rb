def quick_sort(array, start: nil, finish: nil)
  start  ||= 0
  finish ||= array.size - 1

  return if start >= finish

  divider = array.values_at(start, start + (finish - start) / 2, finish).sort[1]

  left  = start
  right = finish
  while left <= right
    left  += 1 while array[left]  < divider
    right -= 1 while array[right] > divider

    if left <= right
      array[left], array[right] = array[right], array[left]
      left  += 1
      right -= 1
    end
  end

  quick_sort(array, start: start, finish: right)
  quick_sort(array, start: left,  finish: finish)

  array
end

# array = 100.times.map { rand(100) }
# array1 = array.sort
# array2 = quick_sort(array)

# p array1
# p array2

# fail unless array1 == array2
