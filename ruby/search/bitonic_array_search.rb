def bitonic_array_search(array, x)
  return -1 if x < array[0] && x < array[array.size - 1]

  # 1. Find bitonic point
  find_bionic_point = lambda do |array, l, r|
    c = (l + r) / 2
    e0 = array[c - 1]
    e1 = array[c]
    e2 = array[c + 1]
    return c if e0 < e1 && e1 > e2

    if e0 < e1 && e1 < e2
      find_bionic_point[array, c + 1, r]
    else
      find_bionic_point[array, l, c - 1]
    end
  end
  k = find_bionic_point.call(array, 0, array.size - 1)
  return -1 if x > array[k]
  return index if x == array[k]

  # 2. Binary search
  bsearch = lambda do |array, l, r, x, dir|
    while l <= r do
      c = l + (r - l) / 2

      case array[c] <=> x
      when 0 then return c
      when dir
        r = c - 1
      else
        l = c + 1
      end
    end
  end

  bsearch.call(array, 0, k - 1, x, 1) || bsearch.call(array, k + 1, array.size - 1, x, -1) || -1
end
