require './board'

class MineSweeper

  attr_reader :board

  def initialize
    @board = Board.new

  end

  def display
    display_board = Array.new(9) {Array.new(9)}

    display_board = @board.board.map do |row|
      row.map do |tile|
        display_square(tile)
      end

    end
    display_board.each do |row|
      puts "||" + row.join("|") + "||"
    end

  end

  def display_square(tile)
    if tile.revealed?
      if tile.bomb_count == 0
        "_"
      elsif tile.bomb_count.nil?
        'B'
      else
        
        tile.bomb_count.to_s
      end

    else
      "*"
    end

  end



end
