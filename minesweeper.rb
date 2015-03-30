require './board'

class Minesweeper



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
      if tile.bomb_counter == 0
        "_"
      else
        tile.bomb_counter.to_s
      end

    else
      "*"
    end

  end



end
