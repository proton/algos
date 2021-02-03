def selection_sort(array):
  for i, _ in enumerate(array):
    min_idx = i
    for j in range((i + 1), len(array)):
      if array[j] < array[min_idx]:
        min_idx = j
    if min_idx != i:
      array[i], array[min_idx] = array[min_idx], array[i]
  return array
