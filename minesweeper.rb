class Board
  attr_reader :board
  BOMB_COUNT = 10

  def initialize
    @board = Array.new(9) {Array.new(9)}
    create_board

  end

  def create_board

    @board.each do |row|
      row.each do |cell|
        @board[row][cell] = Tile.new(@board)
      end
    end

    nil
  end

  def assign_tile_value
    pairs = []


    until pairs.length == BOMB_COUNT
      new_pair = [rand((0...9)),rand((0...9))]
      pairs << new_pair unless pairs.include?(new_pair)
    end

    pairs.each do |pair|
      @board[pair[0]][pair[1]].bombed = true


    end
    

  end



end
