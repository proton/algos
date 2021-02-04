class LinkedList
  attr_reader :head, :length

  def initialize(array = nil)
    @head   = nil
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
    node = LinkedListNode.new(value: value)
    if head.nil?
      @head = node
    else
      last_node.next_node = node
    end
    @length += 1
    value
  end

  def prepend(value)
    @head = LinkedListNode.new(value: value, next_node: @head)
    @length += 1
    value
  end

  def pop
    return nil if head.nil?

    node = pre_last_node
    last_value = node.next_node.value
    node.next_node = nil
    @length -= 1
    last_value
  end

  def pop_front
    return nil if head.nil?

    old_head = head
    @head = head.next_node
    @length -= 1
    old_head.value
  end

  def insert(position, value)
    prev_node = node_at(position - 1)
    next_node = prev_node.next_node
    prev_node.next_node = LinkedListNode.new(value: value, next_node: next_node)
    @length += 1
    value
  end
  
  def remove(position)
    return pop_front if position == 0

    prev_node = node_at(position - 1)
    next_node = prev_node.next_node
    prev_node.next_node = next_node.next_node

    @length -= 1

    next_node.value
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
    node = head
    node = node.next_node while node.next_node
    node
  end

  private def pre_last_node
    node = head
    node = node.next_node while node.next_node&.next_node
    node
  end

  private def node_at(index)
    counter = 0
    node = head
    while node && counter < index
      node = node.next_node
      counter += 1
    end
    node
  end
end

class LinkedListNode
  attr_accessor :value, :next_node

  def initialize(value:, next_node: nil)
    @value     = value
    @next_node = next_node
  end
end

list = LinkedList.new
fail unless list.to_array == []
fail unless list.length == 0


list = LinkedList.new([])
fail unless list.to_array == []
fail unless list.length == 0

list = LinkedList.new([1, 2, 3])
fail unless list.to_array == [1, 2, 3]
fail unless list.length == 3

list.push(4)
fail unless list.length == 4
list.prepend(0)
fail unless list.to_array == [0, 1, 2, 3, 4]
fail unless list.length == 5

fail unless list.pop == 4
fail unless list.length == 4
fail unless list.pop_front == 0
fail unless list.length == 3

list.insert(1, 9)
fail unless list.to_array == [1, 9, 2, 3]
fail unless list.length == 4


list.remove(0)
fail unless list.to_array == [9, 2, 3]
fail unless list.length == 3

list.remove(1)
fail unless list.to_array == [9, 3]
fail unless list.length == 2

fail unless list.at(0) == 9
fail unless list.at(1) == 3
fail unless list.at(2) == nil