def linear_search(array, n):
  indexes = []
  for i, x in enumerate(array):
    if x == n:
      indexes.append(i)
  
  if len(indexes) > 0:
    return indexes
  return -1