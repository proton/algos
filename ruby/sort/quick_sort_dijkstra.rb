def quick_sort_dijkstra(array, start: nil, finish: nil)
  start  ||= 0
  finish ||= array.size - 1

  return if start >= finish

  left    = start
  right   = finish
  i       = start

  divider = array.values_at(start, start + (finish - start) / 2, finish).sort[1]

  while i <= right
    case array[i] <=> divider
    when -1
      array[i], array[left] = array[left], array[i]
      i    += 1
      left += 1
    when 0
      i += 1
    when 1
      array[i], array[right] = array[right], array[i]
      right -= 1
    end
  end

  quick_sort_dijkstra(array, start: start,     finish: left - 1)
  quick_sort_dijkstra(array, start: right + 1, finish: finish  )

  array
end

# array = 100.times.map { rand(100) }
# array1 = array.sort
# array2 = quick_sort_dijkstra(array)

# p array1
# p array2

# fail unless array1 == array2
