class DoublyLinkedList
  class Node
    attr_accessor :value, :prev_node, :next_node

    def initialize(value:, prev_node: nil, next_node: nil)
      @value     = value
      @prev_node = prev_node
      @next_node = next_node
    end
  end

  attr_reader :head, :tail, :length

  def initialize(array = nil)
    @head   = nil
    @tail   = nil
    @length = 0

    return if array.nil?
    array.each do |value|
      push(value)
    end
  end

  def first
    first_node&.value
  end

  def last
    last_node&.value
  end

  def at(index)
    node_at(index)&.value
  end

  def push(value)
    node = Node.new(value: value)
    if length == 0
      @head = node
      @tail = node
    else
      last_node.next_node = node
      node.prev_node = last_node
      @tail = node
    end
    @length += 1
    value
  end

  def prepend(value)
    prev_head = @head
    @head = Node.new(value: value, next_node: prev_head)
    prev_head.prev_node = @head
    @length += 1
    value
  end

  def pop
    return nil if tail.nil?

    last_value = tail.value
    node = tail.prev_node
    node.next_node = nil if node
    @tail = node

    @length -= 1
    last_value
  end

  def pop_front
    return nil if length == 0

    old_head = head
    @head = head.next_node
    @head.prev_node = nil
    @length -= 1
    old_head.value
  end

  def insert(position, value)
    prev_node = node_at(position - 1)
    next_node = prev_node.next_node
    prev_node.next_node = Node.new(value: value, prev_node: prev_node, next_node: next_node)
    @length += 1
    value
  end

  def remove(position)
    return pop_front if position == 0

    prev_node = node_at(position - 1)
    node = prev_node.next_node
    next_node = node.next_node
    prev_node.next_node = next_node
    if next_node
      next_node.prev_node = prev_node
    else
      @tail = prev_node
    end

    @length -= 1

    node.value
  end

  def contains?(value)
    node = head
    while node
      return true if node.value == value
      node = node.next_node
    end
    false
  end

  def to_array
    array = []
    if head
      node = head
      while node
        array << node.value
        node = node.next_node
      end
    end
    array
  end

  private def first_node
    head
  end

  private def last_node
    tail
  end

  private def node_at(index)
    return nil if index >= length

    if index < length / 2
      counter = 0
      node = head
      while node && counter < index
        node = node.next_node
        counter += 1
      end
    else
      counter = length - 1
      node = tail
      while node && counter > index
        node = node.prev_node
        counter -= 1
      end
    end
    node
  end
end

# list = DoublyLinkedList.new
# fail unless list.to_array == []
# fail unless list.length == 0

# list = DoublyLinkedList.new([])
# fail unless list.to_array == []
# fail unless list.length == 0

# list = DoublyLinkedList.new([1, 2, 3])
# fail unless list.to_array == [1, 2, 3]
# fail unless list.length == 3
# fail if     list.contains?(0)
# fail unless list.contains?(1)
# fail unless list.contains?(2)
# fail unless list.contains?(3)
# fail if     list.contains?(4)

# list.push(4)
# fail unless list.length == 4
# list.prepend(0)
# fail unless list.to_array == [0, 1, 2, 3, 4]
# fail unless list.length == 5

# fail unless list.pop == 4
# fail unless list.length == 4
# fail unless list.pop_front == 0
# fail unless list.length == 3

# list.insert(1, 9)
# fail unless list.to_array == [1, 9, 2, 3]
# fail unless list.length == 4


# list.remove(0)
# fail unless list.to_array == [9, 2, 3]
# fail unless list.length == 3

# list.remove(1)
# fail unless list.to_array == [9, 3]
# fail unless list.length == 2

# fail unless list.at(0) == 9
# fail unless list.at(1) == 3
# fail unless list.at(2) == nil
