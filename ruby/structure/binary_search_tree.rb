class BinarySearchTreeNode
  attr_accessor :left, :right, :value

  def initialize(value)
    @value = value
  end

  def has_children?
    has_left_child? || has_right_child?
  end

  def has_both_children?
    has_left_child? && has_right_child?
  end

  def has_no_children?
    !has_children?
  end

  def has_left_child?
    !!left
  end

  def has_right_child?
    !!right
  end

  def replace_child(child, replacement)
    if left == child
      @left = replacement
    elsif right == child
      @right = replacement
    else
      raise ArgumentError, "Child not found"
    end
  end
end

class BinarySearchTree
  attr_reader :root, :size

  def initialize(arr = [])
    @size = 0

    arr.each do |value|
      insert(value)
    end
  end

  def insert(value)
    if root.nil?
      @root = BinarySearchTreeNode.new(value)
    else
      insert_node(root, value)
    end
    @size += 1
  end

  def delete(value)
    node, parent_node = find_node(value)
    return if node.nil?
    @size -= 1

    if parent_node.nil? # it's root
      @root = nil
      return
    end

    if node.has_both_children?
      successor  = node.right
      successor  = successor.left while successor.left
      node.value = successor.value
      delete(successor.value)
    else
      parent_node.replace_child(node, node.left || node.right)
    end
  end

  def has?(value)
    !!find_node(value)
  end

  def to_array(node: root, array: [])
    return array if node.nil?
    to_array(node: node.left,  array: array)
    array << node.value
    to_array(node: node.right, array: array)
    array
  end

  # Use Morris Tree Traversal.
  def each
    current_root = root
    while current_root
      if current_root.left
        current = current_root.left
        current = current.right while current.right
        current.right = current_root

        temp = current_root
        current_root = current_root.left
        temp.left = nil
      else
        yield current_root.value
        current_root = current_root.right
      end
    end
  end

  private def find_node(value, parent: root, grand_parent: nil)
    return if parent.nil?

    if parent.value == value
      [parent, grand_parent]
    elsif value > parent.value
      find_node(value, parent: parent.right, grand_parent: parent)
    else
      find_node(value, parent: parent.left,  grand_parent: parent)
    end
  end

  private def insert_node(node, value)
    if value > node.value
      if node.right
        insert_node(node.right, value)
      else
        node.right = BinarySearchTreeNode.new(value)
      end
    else
      if node.left
        insert_node(node.left, value)
      else
        node.left = BinarySearchTreeNode.new(value)
      end
    end
  end
end

# arr = 100.times.map { rand(1000) }.uniq
# tree = BinarySearchTree.new(arr)

# arr.each do |value|
#   fail unless tree.has?(value)
# end

# fail unless tree.to_array == arr.sort

# sorted = tree.to_array
# tree.each do |value|
#   fail unless value == sorted.shift
# end

# while arr.any?
#   value = arr.pop
#   tree.delete(value)
#   fail if tree.has?(value)

#   arr.each do |value|
#     fail unless tree.has?(value)
#   end

#   fail unless tree.to_array == arr.sort
# end

# fail unless tree.to_array == []
