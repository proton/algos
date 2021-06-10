class AvlTreeNode
  attr_accessor :left, :right, :value, :height

  def initialize(value)
    @value  = value
    @height = 1
  end

  def balance_factor
    right_height - left_height
  end

  def update_height
    @height = [left_height, right_height].max + 1
  end

  private def left_height
    left&.height || 0
  end

  private def right_height
    right&.height || 0
  end
end

class AvlTree
  attr_reader :root, :size

  def initialize(arr = [])
    @size = 0

    arr.each do |value|
      insert(value)
    end
  end

  def insert(value)
    @root = insert_node(root, value)
    @size += 1
  end

  def delete(value)
    @root = delete_node(value, parent: root)
    @size -= 1
  end

  private def delete_node(value, parent: root)
    return nil if parent.nil?

    if value < parent.value
      parent.left = delete_node(value, parent: parent.left)
      rebalance(parent)
    elsif value > parent.value
      parent.right = delete_node(value, parent: parent.right)
      rebalance(parent)
    else
      left_child  = parent.left
      right_child = parent.right

      return left_child if right_child.nil?

      min_node = find_min_node(right_child)
      min_node.right = remove_min_node(right_child)
      min_node.left = left_child

      rebalance(min_node)
    end
  end

  private def find_min_node(parent)
    return find_min_node(parent.left) if parent.left

    parent
  end

  private def remove_min_node(parent)
    return parent.right if parent.left.nil?

    parent.left = remove_min_node(parent.left)
    rebalance(parent)
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

  private def find_node(value, parent: root)
    return if parent.nil?

    if parent.value == value
      parent
    elsif value > parent.value
      find_node(value, parent: parent.right)
    else
      find_node(value, parent: parent.left)
    end
  end

  private def insert_node(node, value)
    return AvlTreeNode.new(value) unless node

    if value < node.value
      node.left  = insert_node(node.left,  value)
    else
      node.right = insert_node(node.right, value)
    end

    rebalance(node)
  end

  private def rebalance(node)
    node.update_height

    if node.balance_factor > 1
      if node.right.balance_factor < 0
        node.right = rotate_right(node.right)
      end
      return rotate_left(node)
    elsif node.balance_factor < -1
      if node.left.balance_factor > 0
        node.left = rotate_left(node.left)
      end
      return rotate_right(node)
    end

    node
  end

  private def rotate_left(root)
    new_root      = root.right
    root.right    = new_root.left
    new_root.left = root

    root.update_height
    new_root.update_height

    new_root
  end

  private def rotate_right(root)
    new_root       = root.left
    root.left      = new_root.right
    new_root.right = root

    root.update_height
    new_root.update_height

    new_root
  end
end

arr = 100.times.map { rand(1000) }.uniq
tree = AvlTree.new(arr)

arr.each do |value|
  unless tree.has?(value)
    p tree.size
    p [:not_have, value, tree.to_array]
    fail
  end
end

fail unless tree.to_array == arr.sort

arr.each do |value|
  tree.delete(value)
  if tree.has?(value)
    p [:has, value, tree.to_array]
    fail
  end
end

fail unless tree.to_array == []
