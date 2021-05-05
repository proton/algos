def quick_sort(array, start: nil, finish: nil)
  start  ||= 0
  finish ||= array.size - 1

  return if start >= finish

  divider = array[start]
  left    = start + 1
  right   = finish

  while left <= right
    left  += 1 while left <= right && array[left]  <  divider
    right -= 1 while left <= right && array[right] >= divider

    if left <= right
      array[left], array[right] = array[right], array[left]
      left += 1
      right -= 1
    end
  end

  array[start], array[right] = array[right], array[start]

  quick_sort(array, start: start,     finish: right - 1)
  quick_sort(array, start: right + 1, finish: finish   )

  array
end

# array = 100.times.map { rand(100) }
# array1 = array.sort
# array2 = quick_sort(array)

# p array1
# p array2

# fail unless array1 == array2
