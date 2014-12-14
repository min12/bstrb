require_relative '../lib/bstrb'

RSpec.describe Bstrb do
  let(:root) { 10 }
  let(:tree) { Bstrb.new(root) }
  let(:nodes) { [6, 11, 4, 8, 12, 5, 7, 9] }

  # Binary Search Tree
  #
  #         10
  #       /    \
  #      6      11
  #    /   \      \
  #   4     8     12
  #    \   / \
  #    5  7   9
  #
  #  Traverse:
  #    - preorder:   10, 6, 4, 5, 8, 7, 9, 11, 12
  #    - inorder:    4, 5, 6, 7, 8, 9, 10, 11, 12
  #    - postorder:  5, 4, 7, 9, 8, 6, 12, 11, 10
  #
  #  Min node val: 4
  #  Max node val: 12

  describe "constructs a tree with some nodes" do
    it "returns a new tree with root" do
      expect(tree.val).to eq(root)
      expect(tree.size).to eq(1)
      expect(tree.left).to eq(nil)
      expect(tree.right).to eq(nil)
    end

    it "inserts some nodes into the tree" do
      size = nodes.size
      nodes.map { |i| tree.insert i }
      expect(tree.size).to eq(size + 1)
    end
  end

  describe "traverses the tree in different orders" do
    let(:preorder_traverse_result) { [10, 6, 4, 5, 8, 7, 9, 11, 12] }
    let(:inorder_traverse_result) { [4, 5, 6, 7, 8, 9, 10, 11, 12] }
    let(:postorder_traverse_result) { [5, 4, 7, 9, 8, 6, 12, 11, 10] }

    before do
      nodes.map {|i| tree.insert i }
      @result = []
    end

    it "is preorder traverse" do
      tree.preorder_traverse do |node|
        @result << node.val
      end
      expect(@result).to eq(preorder_traverse_result)
    end

    it "is inorder traverse" do
      tree.inorder_traverse do |node|
        @result << node.val
      end
      expect(@result).to eq(inorder_traverse_result)
    end

    it "is postorder traverse" do
      tree.postorder_traverse do |node|
        @result << node.val
      end
      expect(@result).to eq(postorder_traverse_result)
    end
  end

  describe "removes some nodes in the tree" do
    let(:remove_4) { [5, 6, 7, 8, 9, 10, 11, 12] }
    let(:remove_12) { [4, 5, 6, 7, 8, 9, 10, 11] }
    let(:remove_6 ) { [4, 5, 7, 8, 9, 10, 11, 12] }
    let(:remove_nonexist_node) { [4, 5, 6, 7, 8, 9, 10, 11, 12] }

    before do
      nodes.map {|i| tree.insert i }
      @result = []
    end

    it "removes 4 the most left node" do
      val = tree.remove(4)
      expect(val).to eq(4)

      tree.inorder_traverse do |node|
        @result << node.val
      end
      expect(@result).to eq(remove_4)
    end

    it "removes 12 the most right node" do
      val = tree.remove(12)
      expect(val).to eq(12)

      tree.inorder_traverse do |node|
        @result << node.val
      end
      expect(@result).to eq(remove_12)
    end

    it "removes 6 having two children" do
      val = tree.remove(6)
      expect(val).to eq(6)

      tree.inorder_traverse do |node|
        @result << node.val
      end
      expect(@result).to eq(remove_6)
    end

    it "removes 20 that is not in the tree" do
      val = tree.remove(20)
      expect(val).not_to eq(20)

      tree.inorder_traverse do |node|
        @result << node.val
      end
      expect(@result).to eq(remove_nonexist_node)
    end
  end

  describe "finds the min or max node" do
    let(:min) { 4 }
    let(:max) { 12 }

    before do
      nodes.map {|i| tree.insert i }
    end

    it "finds the min node" do
      expect(tree.min_node.val).to eq(min)
    end

    it "finds the max node" do
      expect(tree.max_node.val).to eq(max)
    end
  end
end
