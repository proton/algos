class Heap {
  constructor(values = [], compare = (a, b) => a - b) {
    this.data = values
    this.compare = compare

    for (let i = Math.floor(this.size / 2) - 1; i >= 0; --i) {
      this.#heapify(i)
    }
  }

  push(value) {
    this.data.push(value)

    let i = this.size - 1
    let parentI = this.#parentIndex(i)

    while (i > 0 && this.compare(this.data[parentI], this.data[i]) < 0) {
      this.#swap(i, parentI)
      i = parentI
      parentI = this.#parentIndex(i)
    }
  }

  get top() {
    return this.data[0]
  }

  pop() {
    const value = this.top
    const last  = this.data.pop()
    if (this.size > 0) {
      this.data[0] = last
      this.#heapify(0)
    }
    return value
  }

  get size() {
    return this.data.length
  }

  #parentIndex(i) {
    return Math.floor((i - 1) / 2)
  }

  #swap(i, j) {
    [this.data[i], this.data[j]] = [this.data[j], this.data[i]]
  }

  #heapify(i) {
    while (true) {
      const leftChild  = 2 * i + 1
      const rightChild = 2 * i + 2
      let largestChild = i

      if (leftChild < this.size && this.compare(this.data[largestChild], this.data[leftChild]) < 0) {
        largestChild = leftChild
      }
      if (rightChild < this.size && this.compare(this.data[largestChild], this.data[rightChild]) < 0) {
        largestChild = rightChild
      }

      if (largestChild === i) {
        break
      }

      this.#swap(i, largestChild)
      i = largestChild
    }
  }
}

// const arr1 = [8, 9, 5, 2, 1, 6, 7, 4, 10, 3]
// const arr2 = [1, 6, 8, 9, 3, 5, 2, 10, 4, 7]
// const arr3 = [6, 3, 8, 5, 9, 10, 4, 2, 7, 1]

// const heap1 = new Heap(arr1)
// const heap2 = new Heap(arr2)
// const heap3 = new Heap()
// arr3.forEach(x => heap3.push(x))

// const heaps = [heap1, heap2, heap3]
// console.log(heap1.data)
// console.log(heap3.data)

// heaps.forEach(heap => console.assert(heap.top === 10))

// while (heaps[0].size > 0) {
//   heaps.forEach(heap => console.assert(heap.top === heaps[0].size))
//   console.assert(new Set(heaps.map(heap => heap.pop())).size === 1)
// }
