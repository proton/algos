class SortedLinkedList:
  class Node:
    def __init__(self, value, next_node = None):
      self.value     = value
      self.next_node = next_node

  def __init__(self, array = None):
    self.head   = None
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
    node = SortedLinkedList.Node(value)
    if not self.head:
      self.head = node
    elif self.head.value >= value:
      old_head = self.head
      node.next_node = old_head
      self.head = node
    else:
      prev_node = self.head
      while prev_node.next_node and prev_node.next_node.value < value:
        prev_node = prev_node.next_node
      next_node = prev_node.next_node
      prev_node.next_node = node
      node.next_node = next_node
    self.length += 1

  def pop(self):
    if not self.head:
      return None

    node = self.__pre_last_node()
    last_value = node.next_node.value
    node.next_node = None
    self.length -= 1
    return last_value

  def pop_front(self):
    if not self.head:
      return None

    old_head = self.head
    self.head = self.head.next_node
    self.length -= 1
    return old_head.value

  def remove(self, position):
    if position == 0:
      return self.pop_front()

    prev_node = self.__node_at(position - 1)
    next_node = prev_node.next_node
    prev_node.next_node = next_node.next_node

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
    node = self.head
    while node.next_node:
      node = node.next_node
    return node

  def __pre_last_node(self):
    node = self.head
    while node.next_node and node.next_node.next_node:
      node = node.next_node
    return node

  def __node_at(self, index):
    counter = 0
    node = self.head
    while node and counter < index:
      node = node.next_node
      counter += 1
    return node

# list = SortedLinkedList()
# assert list.to_array() == []
# assert list.length == 0

# list = SortedLinkedList([])
# assert list.to_array() == []
# assert list.length == 0

# list = SortedLinkedList([3, 2, 1])
# assert list.to_array() == [1, 2, 3]
# assert list.length == 3
# assert not list.contains(0)
# assert list.contains(1)
# assert list.contains(2)
# assert list.contains(3)
# assert not list.contains(4)

# list.push(4)
# assert list.length == 4
# list.push(0)
# assert list.to_array() == [0, 1, 2, 3, 4]
# assert list.length == 5

# assert list.pop() == 4
# assert list.length == 4
# assert list.pop_front() == 0
# assert list.length == 3

# list.push(9)
# assert list.to_array() == [1, 2, 3, 9]
# assert list.length == 4

# list.remove(0)
# assert list.to_array() == [2, 3, 9]
# assert list.length == 3

# list.remove(1)
# assert list.to_array() == [2, 9]
# assert list.length == 2

# assert list.at(0) == 2
# assert list.at(1) == 9
# assert list.at(2) == None
