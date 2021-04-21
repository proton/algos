def counting_sort(array)
  min = max = array[0]
  (1...array.size).each do |x|
    min = x if x < min
    max = x if x > max
  end

  arr = Array.new(max - min + 1, 0)
  array.each do |x|
    arr[x - min] += 1
  end

  index = 0
  arr.each_with_index do |c, i|
    c.times do
      array[index] = min + i
      index += 1
    end
  end

  array
end

# array = 100.times.map { rand(100) }
# array1 = array.sort
# array2 = counting_sort(array)

# p array1
# p array2

# fail unless array1 == array2
