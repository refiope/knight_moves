class Node
  attr_accessor :move, :left, :right

  def initialize move
    @move = move
    @left = nil
    @right = nil
  end

  def child
    return [@left,@right]
  end

  def no_child?
    return true if @left == nil && @right == nil
  end

  def have_two_child?
    return true if @left != nil && @right != nil
  end

  def not_full?
    num = 0
    child.each { |node| num += 1 if !node.nil? }
    return true if num == 1 || num == 0
  end
end

def build_move (move, move_tree)
  if move_tree.left.nil?
    move_tree.left = Node.new(move)
  elsif move_tree.right.nil?
    move_tree.right = Node.new(move)
  else
    if move_tree.left.not_full?
      build_move(move, move_tree.left)
    elsif move_tree.right.not_full?
      build_move(move, move_tree.right)
    else
      build_move(move, move_tree.left)
    end
  end
end
