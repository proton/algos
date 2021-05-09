def merge_sort(array, start: nil, finish: nil)
  start  ||= 0
  finish ||= array.size - 1

  return if start == finish

  mid = (finish - start) / 2 + start

  merge_sort(array, start: start,   finish: mid)
  merge_sort(array, start: mid + 1, finish: finish)

  # join!
  new_array = []
  i = 0
  j = 0
  loop do
    if i == mid + 1 - start
      new_array += array[(j + mid + 1)..finish]
      break
    end
    if j == finish - mid
      new_array += array[(i + start)..mid]
      break
    end
    x = array[i + start]
    y = array[j + mid + 1]
    if x < y
      new_array << x
      i += 1
    else
      new_array << y
      j += 1
    end
  end
  new_array.each_with_index do |x, i|
    array[start + i] = x
  end

  array
end

array = 100.times.map { rand(100) }
array1 = array.sort
array2 = merge_sort(array)

p array1
p array2

fail unless array1 == array2
