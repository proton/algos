def insertion_sort(array)
  (1...array.size).each do |i|
    key = array[i]
    j = i - 1
    while j >= 0 && array[j] > key
      array[j + 1] = array[j]
      j -= 1
    end
    array[j + 1] = key
  end
  array
end

# array = 100.times.map { rand(100) }
# array1 = array.sort
# array2 = insertion_sort(array)

# p array1
# p array2

# fail unless array1 == array2
