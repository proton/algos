class DoublyLinkedList:
  class Node:
    def __init__(self, value, prev_node = None, next_node = None):
      self.value     = value
      self.prev_node = prev_node
      self.next_node = next_node

  def __init__(self, array = None):
    self.head   = None
    self.tail   = None
    self.length = 0

    if array:
      for value in array:
        self.push(value)

  def first(self):
    node = self.__first_node()
    if node:
      return node.value

  def last(self):
    node = self.__last_node()
    if node:
      return node.value

  def at(self, index):
    node = self.__node_at(index)
    if node:
      return node.value

  def push(self, value):
    node = DoublyLinkedList.Node(value)
    if not self.head:
      self.head = node
      self.tail = node
    else:
      self.__last_node().next_node = node
      node.prev_node = self.__last_node()
      self.tail = node
    self.length += 1

  def prepend(self, value):
    prev_head = self.head
    self.head = DoublyLinkedList.Node(value, next_node = prev_head)
    prev_head.prev_node = self.head
    self.length += 1
    return value

  def pop(self):
    if not self.head:
      return None

    last_value = self.__last_node().value
    node = self.__last_node().prev_node
    if node:
      node.next_node = None
    self.tail = node
    self.length -= 1
    return last_value

  def pop_front(self):
    if not self.head:
      return None

    old_head = self.head
    self.head = self.head.next_node
    self.head.prev_node = None
    self.length -= 1
    return old_head.value

  def insert(self, position, value):
    prev_node = self.__node_at(position - 1)
    next_node = prev_node.next_node
    prev_node.next_node = DoublyLinkedList.Node(value, prev_node=prev_node, next_node = next_node)
    self.length += 1
    return value

  def remove(self, position):
    if position == 0:
      return self.pop_front()

    prev_node = self.__node_at(position - 1)
    node = prev_node.next_node
    next_node = node.next_node
    prev_node.next_node = next_node

    if next_node:
      next_node.prev_node = prev_node
    else:
      self.tail = prev_node

    self.length -= 1
    return next_node.value

  def each(self, callback):
    node = self.head
    while node:
      callback(node.value)
      node = node.next_node

  def contains(self, searchValue):
    node = self.head
    while node:
      if node.value == searchValue:
        return True
      node = node.next_node
    return False

  def to_array(self):
    array = []
    self.each(lambda value: array.append(value))
    return array

  def __first_node(self):
    return self.head

  def __last_node(self):
    return self.tail

  def __node_at(self, index):
    if index >= self.length:
      return None

    if index < self.length / 2:
      counter = 0
      node = self.head
      while node and counter < index:
        node = node.next_node
        counter += 1
    else:
      counter = self.length - 1
      node = self.tail
      while node and counter > index:
        node = node.prev_node
        counter -= 1
    return node

# list = DoublyLinkedList()
# assert list.to_array() == []
# assert list.length == 0

# list = DoublyLinkedList([])
# assert list.to_array() == []
# assert list.length == 0

# list = DoublyLinkedList([1, 2, 3])
# assert list.to_array() == [1, 2, 3]
# assert list.length == 3
# assert not list.contains(0)
# assert list.contains(1)
# assert list.contains(2)
# assert list.contains(3)
# assert not list.contains(4)

# list.push(4)
# assert list.length == 4
# list.prepend(0)
# assert list.to_array() == [0, 1, 2, 3, 4]
# assert list.length == 5

# assert list.pop() == 4
# assert list.length == 4
# assert list.pop_front() == 0
# assert list.length == 3

# list.insert(1, 9)
# assert list.to_array() == [1, 9, 2, 3]
# assert list.length == 4


# list.remove(0)
# assert list.to_array() == [9, 2, 3]
# assert list.length == 3

# list.remove(1)
# assert list.to_array() == [9, 3]
# assert list.length == 2

# assert list.at(0) == 9
# assert list.at(1) == 3
# assert list.at(2) == None
