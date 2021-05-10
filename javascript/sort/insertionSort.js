function insertionSort(array) {
  for (let i = 1; i < array.length; ++i) {
    const key = array[i]
    let j = i - 1
    while(j >= 0 && array[j] > key) {
      array[j + 1] = array[j]
      j -= 1
    }
    array[j + 1] = key
  }

  return array
}

// let arr = [...new Array(20)].map(_ => Math.round(Math.random() * 99))
// console.log(insertionSort(arr))
