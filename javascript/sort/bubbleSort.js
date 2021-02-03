function bubbleSort(array) {
  let isSorted = false
  while(isSorted === false) {
    isSorted = true
    let n = 1

    for(let i = 0; i < array.length - n; ++i) {
      if (array[i] > array[i + 1]) {
        [array[i], array[i + 1]] = [array[i + 1], array[i]]
        isSorted = false
      }
    }

    n += 1
  }
  return array
}

// let arr = [...new Array(20)].map(_ => Math.round(Math.random() * 99))
// console.log(bubbleSort(arr))