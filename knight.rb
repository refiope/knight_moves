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

  def not_full?
    num = 0
    child.each { |node| num += 1 if !node.nil? }
    return true if num == 1 || num == 0
  end
end

class Board
  attr_accessor :board

  def initialize
    @board = []
    8.times { @board.push(["","","","","","","",""]) }
  end

  def find (row, column)
     return @board[row][column]
  end

  def find_knight
    @board.each do |row|
      row.each do |column|
        return [row, column] if find(row, column) == "K"
      end
    end
  end

end

class Knight

  def initialize
    @move_list = [[1,2],[2,1],[-1,-2],[-2,-1],[-1,2],[-2,1],[1,-2],[2,-1]]
    @move_tree = build_move_tree
    @mark = "K"
  end

  def build_move_tree
    root_move = @move_list.pop
    move_tree = Node.new(root_move)
    @move_list.each do |move|
      build_move(move, move_tree)
    end
    return move_tree
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

end

class KnightMove
  def initialize (original_pos, destination)
    @board = Board.new
    @move_tree = Knight.new.build_move_tree
    @original_pos = original_pos
    @destination = destination
  end

  def calculate


  end
end
