def selection_sort(array)
  array.each_index do |i|
    min_idx = i
    ((i + 1)...array.size).each do |j|
      min_idx = j if array[j] < array[min_idx]
    end
    array[i], array[min_idx] = array[min_idx], array[i] unless min_idx == i
  end
  array
end