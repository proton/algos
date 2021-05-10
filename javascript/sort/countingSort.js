function countingSort(array) {
  let min
  let max
  min = max = array[0]

  for (const x of array) {
    if (x < min) min = x
    if (x > max) max = x
  }

  arr = new Array(max - min + 1)
  for (const x of array) {
    arr[x - min] = (arr[x - min] || 0) + 1
  }

  let index = 0
  for (let i = 0; i < arr.length; ++i) {
    const c = arr[i]
    if (!c) continue
    for (let j = 0; j < c; ++j) {
      array[index] = min + i
      index += 1
    }
  }

  return array
}

// let arr = [...new Array(20)].map(_ => Math.round(Math.random() * 99))
// console.log(countingSort(arr))
