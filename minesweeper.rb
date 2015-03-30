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


  private

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
    while true
      puts "choose square to reveal(r), flag(f), or unflag(u) ex: f 1 2"
      input = gets.chomp.downcase.split
      break if valid_input?(input)
      puts "Please provide proper input"
    end

    input
  end

  def valid_input?(input)
    return false unless input.count == 3

    choice = input[0]
    nums = [input[1].to_i, input[2].to_i]

    (choice == 'f' || choice == 'u' || choice == "r") &&
    nums.all? { |el| el.between?(0, 8) }
  end

  def display
    display_board = create_display_screen

    puts "_||#{(0..8).to_a.join("|")}||"
    display_board.each.with_index do |row, idx|
      puts "#{idx}||" + row.join("|") + "||"
    end
  end

  def create_display_screen
    @board.board.map do |row|
      row.map { |tile| display_square(tile) }
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
      tile.flagged? ? 'F' : '*'
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  game = MineSweeper.new
  game.play
end
