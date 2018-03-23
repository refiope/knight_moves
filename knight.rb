class MoveNode
  attr_accessor :position, :parent, :next_positions

  def initialize (current_position, parent=nil)
    @position = current_position
    @parent = parent
    @next_positions = add_next_moves(@position)
  end

  private
  def add_next_moves position
    next_moves = []
    moves = [[1,2],[-1,2],[1,-2],[-1,-2],[2,1],[-2,1],[2,-1],[-2,-1]]

    moves.each do |moved|
      added = [position[0] + moved[0], position[1] + moved[1]]

      if (position[0] + moved[0]).between?(0,7) &&
         (position[1] + moved[1]).between?(0,7) &&
        next_moves.push(added)
      end
    end
    return next_moves
  end

end

class Board
  attr_accessor :board

  def initialize
    @board = []
    8.times { @board.push(Array.new(8,"-")) }
  end

  def visited? coordinate
    return false if coordinate == nil
    return false if @board[coordinate[0]][coordinate[1]] == "-"
    return true
  end

  def mark coordinate
    @board[coordinate[0]][coordinate[1]] == "x"
  end
end

def knight_moves (start, finish)
  queue = []
  final_node = nil

  knight = MoveNode.new(start)
  board = Board.new

  return knight.position if knight.position == finish

  queue.push(knight)
  board.mark(start)

  queue.each  do |node|
    parent = node.parent

    node.next_positions.each do |move|
        if move == finish
          final_node = node
          break
        end
        board.visited?(move) ? next : board.mark([move[0],move[1]])
        new_moves = MoveNode.new(move, node)
        queue.push(new_moves)
    end

    until queue[0].parent == parent
      queue.shift
    end
  end

  steps = []
  until final_node.parent == nil
    steps.push(final_node.position)
    final_node = final_node.parent
  end
  steps = steps.reverse
  steps.unshift(start)
  steps.push(finish)
  steps.each { |move| puts move.inspect }
  puts "It took #{steps.length-1} moves to reach to the destination."
end
