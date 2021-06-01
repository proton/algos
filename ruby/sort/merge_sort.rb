def merge_sort(array, start: nil, finish: nil, buffer: nil)
  start  ||= 0
  finish ||= array.size - 1
  buffer ||= Array.new(array.size)

  return if start == finish

  mid = (finish - start) / 2 + start

  merge_sort(array, start: start,   finish: mid,    buffer: buffer)
  merge_sort(array, start: mid + 1, finish: finish, buffer: buffer)

  i = 0
  j = 0
  b = 0
  loop do
    remaining = (j + mid + 1)..finish if i == mid + 1 - start
    remaining = (i + start)..mid      if j == finish - mid
    if remaining
      remaining.each do |k|
        buffer[b] = array[k]
        b += 1
      end
      break
    end
    x = array[i + start]
    y = array[j + mid + 1]
    if x < y
      buffer[b] = x
      i += 1
    else
      buffer[b] = y
      j += 1
    end
    b += 1
  end
  (0...b).each do |k|
    array[start + k] = buffer[k]
  end

  array
end

# array = 100.times.map { rand(100) }
# array1 = array.sort
# array2 = merge_sort(array)

# p array1
# p array2

# fail unless array1 == array2
