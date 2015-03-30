require './tile'

class Board
  attr_reader :board
  BOMB_COUNT = 10
  BOARD_SIZE = 9

  def self.valid_position?(pos)
    pos.all? { |num| num.between?(0, BOARD_SIZE - 1) }
  end

  def initialize
    @board = Array.new(BOARD_SIZE) { Array.new(BOARD_SIZE) }
    create_board
  end


  def show_board
    act_on_board do |row_idx, col_idx|
      tile = @board[row_idx][col_idx]
      tile.revealed = true
    end

    nil
  end

  def game_won?
    # make sure everything is revealed or
    revealed_count = 0

    @board.each_with_index do |row, row_idx|
      row.count.times do |col_idx|
        tile = @board[row_idx][col_idx]
        revealed_count += 1 if tile.revealed?
      end
    end

    revealed_count == BOARD_SIZE * BOARD_SIZE - BOMB_COUNT
  end

  def create_display_screen
    @board.map do |row|
      row.map { | tile | tile.render_display_square }
    end
  end

  def [](row)
    @board[row]
  end



  private

  def create_board
    act_on_board do |row_idx, col_idx|
      @board[row_idx][col_idx] = Tile.new(self, [row_idx, col_idx])
    end

    assign_bombs
    update_bomb_count

    nil
  end

  def act_on_board(&prc)
    @board.each_with_index do |row, row_idx|
      row.count.times do |col_idx|
        prc.call(row_idx, col_idx)
      end
    end

    nil
  end


  def assign_bombs
    pairs = []
    until pairs.length == BOMB_COUNT
      new_pair = [rand((0...BOARD_SIZE)),rand((0...BOARD_SIZE))]
      pairs << new_pair unless pairs.include?(new_pair)
    end

    pairs.each do |pair|
      @board[pair.first][pair.last].bomb_count = nil
    end

    nil
  end

  def update_bomb_count
    act_on_board do |row_idx, col_idx|
      tile = @board[row_idx][col_idx]
      tile.bomb_counter
    end

    nil
  end
end
