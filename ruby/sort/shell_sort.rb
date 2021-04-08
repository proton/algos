def shell_sort(array)
  d = array.size / 2
  while d > 0 do
    (d...array.size).each do |i|
      key = array[i]
      j = i - d
      while j >= 0 && array[j] > key
        array[j + d] = array[j]
        j -= d
      end
      array[j + d] = key
    end
    d = d / 2
  end
  array
end

# array = 100.times.map { rand(100) }
# array1 = array.sort
# array2 = shell_sort(array)

# p array1
# p array2

# fail unless array1 == array2
