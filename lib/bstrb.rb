class Node
  attr_accessor :val, :left, :right, :size

  def initialize(val, left = nil, right = nil)
    @val = val
    @left = left
    @right = right
    @size = 1
  end

  def has_left_child?
    !!@left
  end

  def has_right_child?
    !!@right
  end

  def size
    @size += left.size if !left.nil?
    @size += right.size if !right.nil?
    @size
  end
end

class Bstrb < Node
  attr_reader :val, :left, :right, :size

  def initialize(val)
    @root = Node.new(val)
  end

  def val
    @root.val
  end

  def left
    @root.left
  end

  def right
    @root.right
  end

  def size
    @root.size
  end

  # Insert what a node contains.
  def insert(other)
    current = @root
    while !current.nil?
      # The tree cannot have two nodes containing the same value.
      if other == current.val
        return
      elsif other < current.val && current.left == nil
        current.left = Node.new(other)
      elsif other > current.val && current.right == nil
        current.right = Node.new(other)
      elsif other < current.val
        current = current.left
      elsif other > current.val
        current = current.right
      end
    end
  end

  # A block needs to be passed in `*_traverse` method to process every node or
  # nothing returns.
  def preorder_traverse(node = @root, &blk)
    return if node.nil?
    yield node if block_given?
    preorder_traverse(node.left, &blk)
    preorder_traverse(node.right, &blk)
  end

  def inorder_traverse(node = @root, &blk)
    return if node.nil?
    inorder_traverse(node.left, &blk)
    yield node if block_given?
    inorder_traverse(node.right, &blk)
  end

  def postorder_traverse(node = @root, &blk)
    return if node.nil?
    postorder_traverse(node.left, &blk)
    postorder_traverse(node.right, &blk)
    yield node if block_given?
  end

  # Remove a node value and return it.
  # If it is not found in the tree return false.
  def remove(val)
    current = @root
    parent = nil
    while true
      if val < current.val
        if current.has_left_child?
          parent = current
          current = current.left
        else
          return false
        end
      elsif val > current.val
        if current.has_right_child?
          parent = current
          current = current.right
        else
          return false
        end
      else
        # Find the node.
        return remove_node(current, parent)
      end
    end
  end

  # The min node in the tree.
  def min_node
    current = @root
    while current.has_left_child?
      current = current.left
    end
    current
  end

  # The max node in the tree.
  def max_node
    current = @root
    while current.has_right_child?
      current = current.right
    end
    current
  end

  private

  def remove_node(current, parent)
    val = current.val

    if current.has_left_child? && current.has_right_child?
      node = current.right
      # Search the first node bigger than this node and then replace it.
      while node.has_left_child?
        parent = node
        node = node.left
      end
      current.val = node.val
      parent.left = nil
      node = nil
    elsif current.has_left_child?
      if parent.has_left_child?
        parent.left = current.left
      else
        parent.right = current.left
      end
    elsif current.has_right_child?
      if parent.has_left_child?
        parent.left = current.right
      else
        parent.right = current.right
      end
    else
      parent.left = nil if parent.has_left_child?
      parent.right = nil if parent.has_right_child?
      current = nil
    end

    val
  end
end
