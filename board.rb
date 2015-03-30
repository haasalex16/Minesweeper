require './tile'

class Board
  attr_reader :board
  BOMB_COUNT = 10

  def initialize
    @board = Array.new(9) {Array.new(9)}
    create_board

  end

  def create_board

    @board.each_with_index do |row, row_idx|
      row.count.times do |col_idx|
        @board[row_idx][col_idx] = Tile.new(self, [row_idx, col_idx])
      end
    end

    assign_bombs
    update_bomb_count

    nil
  end

  def show_board
    @board.each_with_index do |row, row_idx|
      row.count.times do |col_idx|
        tile = @board[row_idx][col_idx]
        tile.revealed = true
      end
    end
  end

  def assign_bombs
    pairs = []

    until pairs.length == BOMB_COUNT
      new_pair = [rand((0...9)),rand((0...9))]
      pairs << new_pair unless pairs.include?(new_pair)
    end

    pairs.each do |pair|
      @board[pair[0]][pair[1]].bomb_count = nil
    end

  end

  def update_bomb_count
    @board.each_with_index do |row, row_idx|
      row.count.times do |col_idx|
        tile = @board[row_idx][col_idx]
        tile.bomb_counter
      end
    end

  end


end
