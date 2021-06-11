class RedBlackTreeNode
  attr_accessor :parent, :left, :right, :value, :color

  def initialize(value, parent: nil, color: :red)
    @value  = value
    @parent = parent
    @color  = color
  end

  def black?
    color == :black
  end

  def red?
    color == :red
  end

  def make_black
    @color = :black
  end

  def make_red
    @color = :red
  end

  def left_child?
    parent&.left == self
  end

  def right_child?
    parent&.right == self
  end

  def grandparent
    parent&.parent
  end

  def uncle
    gp = grandparent
    return unless gp

    if gp.left == parent
      gp.right
    else
      gp.left
    end
  end

  def childless?
    children_count == 0
  end

  def children_count
    (left ? 1 : 0) + (right ? 1 : 0)
  end

  def child(direction)
    public_send(direction)
  end

  def set_child(direction, node)
    public_send("#{direction}=", node)
  end

  def root?
    parent.nil?
  end
end

class RedBlackTree
  attr_reader :root, :size

  def initialize(arr = [])
    @size = 0

    arr.each do |value|
      insert(value)
    end
  end

  def insert(value)
    if root.nil?
      @root = RedBlackTreeNode.new(value, color: :black)
    else
      node = insert_node(root, value)
      node.make_red
      balance_insertion(node)
    end
    @size += 1
  end

  def balance_insertion(node)
    while node.parent&.red?
      parent = node.parent
      grandparent = node.grandparent

      if parent.left_child?
        if node.uncle&.red?
          parent.make_black
          node.uncle.make_black
          grandparent.make_red
          node = grandparent
        else
          if node.right_child?
            node = parent
            rotate_left(node)
          end
          parent.make_black
          grandparent.make_red
          rotate_right(grandparent)
        end
      else # if parent.right_child?
        if node.uncle&.red?
          parent.make_black
          node.uncle.make_black
          grandparent.make_red
          node = grandparent
        else
          if node.left_child?
            node = parent
            rotate_right(node)
          end
          parent.make_black
          if grandparent
            grandparent.make_red
            rotate_left(grandparent)
          end
        end
      end
    end
    root.make_black
  end

  def rotate_left(node)
    rotate(node, :left)
  end

  def rotate_right(node)
    rotate(node, :right)
  end

  def rotate(node, direction)
    adirection = direction == :right ? :left : :right

    pivot  = node.child(adirection)
    parent = node.parent
    pivot.parent = parent

    if parent
      parent.set_child(node.left_child? ? :left : :right, pivot)
    else
      @root = pivot
    end

    node.parent = pivot
    node.set_child(adirection, pivot.child(direction))

    brother = pivot.child(direction)
    brother.parent = node if brother
    pivot.set_child(direction, node)
  end

  def delete(value)
    node, parent = find_node(value)
    return unless node

    if parent.nil? # it's root
      @root = nil
    else
      remove_from_parent(node)
    end

    @size -= 1
  end

  private def remove_from_parent(node)
    parent = node.parent

    if node.childless?
      parent.set_child(node.left_child? ? :left : :right, nil)
      # TODO: balance me
    elsif node.children_count == 1
      child = node.left || node.right
      parent.set_child(node.left_child? ? :left : :right, child)
      # TODO: balance me
    else # node.children_count == 2
      next_node = node.right
      next_node = next_node.left while next_node.left

      node.value = next_node.value
      remove_from_parent(next_node)
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
        return insert_node(node.right, value)
      else
        child = RedBlackTreeNode.new(value, parent: node)
        node.right = child
        return child
      end
    else
      if node.left
        return insert_node(node.left, value)
      else
        child = RedBlackTreeNode.new(value, parent: node)
        node.left = child
        return child
      end
    end
  end
end

arr = 1000.times.map { rand(1000) }.uniq
tree = RedBlackTree.new(arr)

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
