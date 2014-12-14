# Binary Search Tree in Ruby

## Some examples

~~~
# Construct a tree and inserts some nodes.
tree = Bstrb.new(10)
[6, 11, 4, 8, 12, 5, 7, 9].map { |node| tree.insert node }

# Traverse the tree.
tree.inorder_traverse do |node|
  puts node.val
end

# Remove a node from the tree.
tree.remove(6)

# Find the min node in the tree.
tree.min_node

# Find the max node in the tree. 
tree.max_node
~~~

## How to test

~~~
cd spec
rspec bstrb_spec.rb --format doc
~~~
