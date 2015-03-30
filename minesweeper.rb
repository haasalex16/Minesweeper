require './board'

class MineSweeper

  attr_reader :board

  def initialize
    @board = Board.new
  end

  def play
    output = true
    until output == false || game_won?
      display
      input = read_input
      output = make_move(input)
    end

    @board.show_board
    display

    if game_won?
      puts "You Win! congrats"
    else
      puts "Sorry buddy"
    end
  end

  def game_won?
    # make sure everything is revealed or
    revealed_count = 0

    @board.board.each_with_index do |row, row_idx|
      row.count.times do |col_idx|
        tile = @board.board[row_idx][col_idx]
        revealed_count += 1 if tile.revealed?
      end
    end

    revealed_count == 81 - Board::BOMB_COUNT
  end



  def make_move(input)
    move = input[0]
    position = [input[1].to_i, input[2].to_i]

    tile = @board.board[position[0]][position[1]]

    if move == 'f'
      tile.flagged = true
      true
    elsif move == 'u'
      tile.flagged = false
      true
    else
      tile.reveal
    end

  end

  def read_input
    puts "choose square to reveal(r), flag(f), or unflag(u) ex: f 1 2"
    gets.chomp.split
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
      if tile.flagged?
        'f'
      else
        "*"
      end
    end

  end
end

if __FILE__ == $PROGRAM_NAME
  game = MineSweeper.new
  game.play
end
