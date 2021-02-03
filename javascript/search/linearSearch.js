function linearSearch(array, n) {
  for (const [i, x] of array.entries()) {
    if (x === n) return i
  }
  return - 1
}