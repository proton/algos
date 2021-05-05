def quick_sort(array, start: nil, finish: nil, buffer: nil)
  start  ||= 0
  finish ||= array.size - 1
  buffer ||= Array.new(array.size - 1)

  return if start >= finish

  divider = array[start]

  low_i  = -1
  high_i =  0

  (start + 1).upto(finish) do |i|
    x = array[i]
    if x < divider
      low_i += 1
      buffer[low_i] = x
    else
      high_i -= 1
      buffer[high_i] = x
    end
  end

  index = start
  while low_i >= 0
    array[index] = buffer[low_i]
    index += 1
    low_i -= 1
  end

  array[index] = divider

  midpoint = index

  index += 1
  while high_i < 0
    array[index] = buffer[high_i]
    index += 1
    high_i += 1
  end

  quick_sort(array, start: start,        finish: midpoint - 1, buffer: buffer)
  quick_sort(array, start: midpoint + 1, finish: finish,       buffer: buffer)

  array
end

# array = 100.times.map { rand(100) }
# array1 = array.sort
# array2 = quick_sort(array)

# p array1
# p array2

# fail unless array1 == array2
