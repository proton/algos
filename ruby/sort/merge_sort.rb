def merge_sort(array, start: nil, finish: nil, buffer: nil)
  start  ||= 0
  finish ||= array.size - 1
  buffer ||= Array.new(array.size)

  return if start == finish

  mid = (finish - start) / 2 + start

  merge_sort(array, start: start,   finish: mid)
  merge_sort(array, start: mid + 1, finish: finish)

  i = 0
  j = 0
  b = 0
  loop do
    if i == mid + 1 - start
      ((j + mid + 1)..finish).each do |k|
        buffer[b] = array[k]
        b += 1
      end
      break
    end
    if j == finish - mid
      ((i + start)..mid).each do |k|
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
      b += 1
    else
      buffer[b] = y
      j += 1
      b += 1
    end
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
