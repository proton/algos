def linear_search(array, n):
  for i, x in enumerate(array):
    if x == n:
      return i
  return -1
