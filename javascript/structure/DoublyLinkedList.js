class DoublyLinkedList {
  constructor(array) {
    this.head   = null
    this.tail   = null
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
    const node = this.tail
    if (node) return node.value
  }

  at(index) {
    const node = this._nodeAt(index)
    if (node) return node.value
  }

  push(value) {
    const node = new DoublyLinkedListNode({value: value})
    if (this.head === null) {
      this.head = node
      this.tail = node
    } else {
      this._lastNode().nextNode = node
      node.prevNode = this._lastNode()
      this.tail = node
    }
    this.length += 1
    return value
  }

  prepend(value) {
    const prevHead = this.head
    this.head = new DoublyLinkedListNode({value: value, nextNode: prevHead})
    prevHead.prevNode = this.head
    this.length += 1
    return value
  }

  pop() {
    if (!this.tail) return null

    const lastValue = this.tail.value
    const node = this.tail.prevNode
    if (node) node.nextNode = null
    this.tail = node

    this.length -= 1
    return lastValue
  }
  
  popFront() {
    if (!this.head) return null

    const oldHead = this.head
    this.head = oldHead.nextNode
    this.head.prevNode = null
    this.length -= 1
    return oldHead.value
  }

  insert(position, value) {
    const prevNode = this._nodeAt(position - 1)
    const nextNode = prevNode.nextNode
    prevNode.nextNode = new DoublyLinkedListNode({value: value, prevNode: prevNode, nextNode: nextNode})
    this.length += 1
    return value
  }

  remove(position) {
    if (position === 0) return this.popFront()

    const prevNode = this._nodeAt(position - 1)
    const node = prevNode.nextNode
    const nextNode = node.nextNode
    prevNode.nextNode = nextNode
    if (nextNode) {
      nextNode.prevNode = prevNode
    } else {
      this.tail = prevNode
    }

    this.length -= 1
    return nextNode.value
  }

  toArray() {
    const array = []
    if (this.head) {
      let node = this.head
      while(node) {
        array.push(node.value)
        node = node.nextNode
      }
    }
    return array
  }

  _lastNode() {
    return this.tail
  }

  _nodeAt(index) {
    if (index >= this.length) return undefined
    
    let node
    if (index < this.length / 2) {
      let counter = 0
      node = this.head
      while(node && counter < index) {
        node = node.nextNode
        counter += 1
      }
    } else {
      let counter = this.length - 1
      node = this.tail
      while(node && counter > index) {
        node = node.prevNode
        counter -= 1
      }
    }
    return node
  }
}

class DoublyLinkedListNode {
  constructor({value, prevNode, nextNode}) {
    this.value    = value
    this.prevNode = prevNode
    this.nextNode = nextNode           
  }
}

// arrayEquals = (a, b) => Array.isArray(a) && Array.isArray(b) && a.length === b.length && a.every((val, index) => val === b[index])

// let list = new DoublyLinkedList
// console.assert(arrayEquals(list.toArray(), []))
// console.assert(list.length === 0)

// list = new DoublyLinkedList([])
// console.assert(arrayEquals(list.toArray(), []))
// console.assert(list.length === 0)

// list = new DoublyLinkedList([1, 2, 3])
// console.assert(arrayEquals(list.toArray(), [1, 2, 3]))
// console.assert(list.length === 3)

// list.push(4)
// console.assert(list.length === 4)
// list.prepend(0)
// console.assert(arrayEquals(list.toArray(), [0, 1, 2, 3, 4]))
// console.assert(list.length === 5)


// console.assert(list.pop() === 4)
// console.assert(list.length === 4)
// console.assert(list.popFront() === 0)
// console.assert(list.length === 3)

// list.insert(1, 9)
// console.assert(arrayEquals(list.toArray(), [1, 9, 2, 3]))
// console.assert(list.length === 4)


// list.remove(0)
// console.assert(arrayEquals(list.toArray(), [9, 2, 3]))
// console.assert(list.length === 3)

// list.remove(1)
// console.assert(arrayEquals(list.toArray(), [9, 3]))
// console.assert(list.length === 2)

// console.assert(list.at(0) === 9)
// console.assert(list.at(1) === 3)
// console.assert(list.at(2) === undefined)