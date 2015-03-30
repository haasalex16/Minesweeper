class Tile
   attr_reader :bomb_count

   NEIGHBORS = [
     [1,1],
     [1,0],
     [-1,0]
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

  def bomb_counter
    create_neighbors.each do |neighbor|
      @bomb_count += 1 if neighbor.bombed?
    end

    nil
  end


  def create_neighbors
    valid_neighbors = []

    NEIGHBORS.each do |neighbor|

      new_pos = [pos[0] + neighbor[0], pos[1] + neighbor[1]]

      if valid_neighbor?(new_pos)
        tile = @board.board[new_pos.first][new_pos.last]
        valid_neighbors << tile
      end

    end
    valid_neighbors
  end

  def valid_neighbor?(pos)
    pos[0].between?(0, 8) && pos[1].between?(0, 8)
  end

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
    bomb_counter
    @revealed = true

    if bomb_count == 0
      neighbors = create_nieghbors
      neighbors.each do |neighbor|
        neighbor.reveal
      end
    end

    true
  end

end
