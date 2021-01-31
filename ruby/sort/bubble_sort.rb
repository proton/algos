def bubble_sort(array)
  is_sorted = false
  until is_sorted do
    is_sorted = true
    n = 1

    (0...(array.size) - n).each do |i|
      if array[i] > array[i + 1]
        array[i], array[i + 1] = array[i + 1], array[i]
        is_sorted = false
      end
    end

    n += 1
  end
  array
end
