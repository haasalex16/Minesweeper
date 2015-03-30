class Tile
   attr_reader :bombed

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
     @bombed = false
     @flagged = false
     @revealed = false
     @position = pos
  end

  def bomb_count
    bomb_count = 0

    create_neighbors.each do |neighbor|
      bomb_count += 1 if neighbor.bombed
    end

    bomb_count
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



end