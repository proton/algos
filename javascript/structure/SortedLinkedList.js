class SortedLinkedList {
  constructor(array) {
    this.head   = null
    this.length = 0

    if (array) {
      for (const value of array) {
        this.push(value)
      }
    }
  }

  first() {
    const node = this.head
    if (node) return node.value
  }

  last() {
    const node = this._lastNode()
    if (node) return node.value
  }

  at(index) {
    const node = this._nodeAt(index)
    if (node) return node.value
  }

  push(value) {
    const node = new LinkedListNode({value: value})
    if (this.head === null) {
      this.head = node
    } else if (this.head.value >= value) {
      const oldHead = this.head
      node.nextNode = oldHead
      this.head = node
    } else {
      let prevNode = this.head
      while (prevNode.nextNode && prevNode.nextNode.value < value) {
        prevNode = prevNode.nextNode
      }
      const nextNode = prevNode.nextNode
      prevNode.nextNode = node
      node.nextNode = nextNode
    }
    this.length += 1
    return value
  }

  pop() {
    if (!this.head) return null

    const node = this._preLastNode()
    const lastValue = node.nextNode.value
    node.nextNode = null
    this.length -= 1
    return lastValue
  }

  popFront() {
    if (!this.head) return null

    const oldHead = this.head
    this.head = oldHead.nextNode
    this.length -= 1
    return oldHead.value
  }

  remove(position) {
    if (position === 0) return this.popFront()

    const prevNode = this._nodeAt(position - 1)
    const nextNode = prevNode.nextNode
    prevNode.nextNode = nextNode.nextNode
    this.length -= 1
    return nextNode.value
  }

  each(callback) {
    let node = this.head
    while(node) {
      callback(node.value)
      node = node.nextNode
    }
  }

  contains(searchValue) {
    let node = this.head
    while(node) {
      if (node.value == searchValue) return true
      node = node.nextNode
    }
    return false
  }

  toArray() {
    const array = []
    this.each(value => array.push(value))
    return array
  }

  _lastNode() {
    let node = this.head
    while(node.nextNode) {
      node = node.nextNode
    }
    return node
  }

  _preLastNode() {
    let node = this.head
    while(node.nextNode && node.nextNode.nextNode) {
      node = node.nextNode
    }
    return node
  }

  _nodeAt(index) {
    let counter = 0
    let node = this.head
    while(node && counter < index) {
      node = node.nextNode
      counter += 1
    }
    return node
  }
}

class LinkedListNode {
  constructor({value, nextNode}) {
    this.value    = value
    this.nextNode = nextNode
  }
}

// arrayEquals = (a, b) => Array.isArray(a) && Array.isArray(b) && a.length === b.length && a.every((val, index) => val === b[index])

// let list = new SortedLinkedList
// console.assert(arrayEquals(list.toArray(), []))
// console.assert(list.length === 0)

// list = new SortedLinkedList([])
// console.assert(arrayEquals(list.toArray(), []))
// console.assert(list.length === 0)

// list = new SortedLinkedList([3, 2, 1])
// console.assert(arrayEquals(list.toArray(), [1, 2, 3]))
// console.assert(list.length === 3)
// console.assert(!list.contains(0))
// console.assert(list.contains(1))
// console.assert(list.contains(2))
// console.assert(list.contains(3))
// console.assert(!list.contains(4))

// list.push(4)
// console.assert(list.length === 4)
// list.push(0)
// console.assert(arrayEquals(list.toArray(), [0, 1, 2, 3, 4]))
// console.assert(list.length === 5)

// console.assert(list.pop() === 4)
// console.assert(list.length === 4)
// console.assert(list.popFront() === 0)
// console.assert(list.length === 3)

// list.push(9)
// console.assert(arrayEquals(list.toArray(), [1, 2, 3, 9]))
// console.assert(list.length === 4)

// list.remove(0)
// console.assert(arrayEquals(list.toArray(), [2, 3, 9]))
// console.assert(list.length === 3)

// list.remove(1)
// console.assert(arrayEquals(list.toArray(), [2, 9]))
// console.assert(list.length === 2)

// console.assert(list.at(0) === 2)
// console.assert(list.at(1) === 9)
// console.assert(list.at(2) === undefined)
