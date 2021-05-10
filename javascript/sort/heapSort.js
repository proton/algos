function heapSort(array) {
  const swap = function(i, j) {
    [array[i], array[j]] = [array[j], array[i]]
  }

  const heapify = function(i, size) {
    while(true) {
      const left_child  = 2 * i + 1
      const right_child = 2 * i + 2
      let   largest_child = i

      if (left_child  < size && array[left_child]  > array[largest_child]) largest_child = left_child
      if (right_child < size && array[right_child] > array[largest_child]) largest_child = right_child

      if (largest_child === i) break

      swap(i, largest_child)
      i = largest_child
    }
  }

  for (let i = array.length / 2 - 1; i >= 0; --i) {
    heapify(i, array.length)
  }

  for (let i = 0; i < array.length; ++i) {
    const last = array.length - 1 - i
    swap(0, last)
    heapify(0, last)
  }

  return array
}

// let arr = [...new Array(20)].map(_ => Math.round(Math.random() * 99))
// console.log(heapSort(arr))
