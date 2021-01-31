def linear_search(array, n)
  array.each_with_index do |x, i|
    return i if x == n
  end
  -1
end
