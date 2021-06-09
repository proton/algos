class BinarySearchTreeNode
  attr_accessor :left, :right, :value

  def initialize(value)
    @value = value
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
    if node
      if parent_node
        if parent_node.left == node
          parent_node.left = nil
        else
          parent_node.right = nil
        end
      else # it's root
        @root = nil
      end
      @size -= 1
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

# arr.each do |value|
#   tree.delete(value)
#   fail if tree.has?(value)
# end

# fail unless tree.to_array == []
