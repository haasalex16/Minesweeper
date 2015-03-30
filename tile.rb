require 'byebug'

class Tile
   attr_accessor :bomb_count, :flagged, :revealed

   NEIGHBORS = [
     [1,1],
     [1,0],
     [-1,0],
     [-1, -1],
     [0, 1],
     [0, -1],
     [1, -1],
     [-1, 1]
   ]

  def initialize(board, pos)
     @board = board
     @bomb_count = 0
     @flagged = false
     @revealed = false
     @position = pos
  end

  def render_display_square
    if revealed?
      if bomb_count == 0
        "_"
      elsif bomb_count.nil?
        'B'
      else
        bomb_count.to_s
      end
    else
      flagged? ? 'F' : '*'
    end
  end

  def bomb_counter
    return nil if bombed?

    create_neighbors.each do |neighbor|
      @bomb_count += 1 if neighbor.bombed?
    end

    nil
  end

  def create_neighbors
    valid_neighbors = []

    NEIGHBORS.each do |neighbor|
      new_pos = [@position.first + neighbor.first, @position.last + neighbor.last]

      if Board.valid_position?(new_pos)
        tile = @board.board[new_pos.first][new_pos.last]
        valid_neighbors << tile
      end
    end

    valid_neighbors
  end

  # def valid_neighbor?(pos)
  #   pos.first.between?(0, Board::BOARD_SIZE - 1) &&
  #   pos.last.between?(0, Board::BOARD_SIZE - 1)
  # end

  def bombed?
    bomb_count.nil?
  end

  def revealed?
    @revealed
  end

  def flagged?
    @flagged
  end

  # returns false if there is a bomb in place and true otherwise
  def reveal
    return false if bombed?

    @revealed = true

    if bomb_count == 0
      neighbors = create_neighbors
      neighbors.each do |neighbor|
        neighbor.reveal unless neighbor.revealed?
      end
    end

    true
  end
end
