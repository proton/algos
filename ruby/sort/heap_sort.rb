def heap_sort(array)
  swap = lambda do |i, j|
    array[i], array[j] = array[j], array[i]
  end

  heapify = lambda do |i, size|
    loop do
      left_child  = 2 * i + 1
      right_child = 2 * i + 2
      largest_child = i

      largest_child = left_child  if left_child < size  && array[left_child]  > array[largest_child]
      largest_child = right_child if right_child < size && array[right_child] > array[largest_child]

      break if largest_child == i

      swap.call(i, largest_child)
      i = largest_child
    end
  end

  # build heap
  (array.size / 2 - 1).downto(0).each do |i|
    heapify.call(i, array.size)
  end

  (0...array.size).each do |i|
    last = array.size - 1 - i
    swap.call(0, last)
    heapify.call(0, last)
  end

  array
end

# array = 100.times.map { rand(100) }
# array1 = array.sort
# array2 = heap_sort(array)

# p array1
# p array2

# fail unless array1 == array2
