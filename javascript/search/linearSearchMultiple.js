function linearSearchMultiple(array, n) {
  const indexes = []
  for (const [i, x] of array.entries()) {
    if (x === n) indexes.push(i)
  }
  return indexes.length ? indexes : -1
}