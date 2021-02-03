function selectionSort(array) {
  for(let i = 0; i < array.length; ++i) {
    let min_idx = i
    for(let j = i + 1; j < array.length; ++j) {
      if (array[j] < array[min_idx]) min_idx = j
    }
    if (min_idx !== i) [array[i], array[min_idx]] = [array[min_idx], array[i]]
  }
  
  return array
}

// let arr = [...new Array(20)].map(_ => Math.round(Math.random() * 99))
// console.log(selectionSort(arr))