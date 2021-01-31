def linear_search_multiple(array, n)
  indexes = array.filter_map.with_index { |x, i| i if x == n }
  return -1 if indexes.empty?
  indexes
end
