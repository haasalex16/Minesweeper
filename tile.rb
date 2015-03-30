require 'byebug'

class Tile
   attr_accessor :bomb_count, :flagged, :revealed, :bomb

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
     @bomb = false
     @flagged = false
     @revealed = false
     @position = pos
  end

  def move(input)
    p input
    if input == 'f'
      @flagged = true
      true
    elsif input == 'u'
      @flagged = false
      true
    else
      reveal
    end
  end

  def render_display_square
    if revealed?
      if bombed?
        'B'
      elsif bomb_count == 0
        '_'
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
        tile = @board[new_pos.first][new_pos.last]
        valid_neighbors << tile
      end
    end

    valid_neighbors
  end

  def bombed?
    @bomb
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
