require './board'

class MineSweeper

  attr_reader :board

  def initialize
    @board = Board.new
  end

  def play
    output = true
    start_time = Time.now

    until output == false || @board.game_won?
      display
      input = read_input
      output = make_move(input)
    end

    if @board.game_won?
      puts "You Win! Congrats!"
      end_time = Time.now
      total_time = end_time - start_time

      puts "Total Time: #{total_time}"

    else
      puts "Sorry buddy..."
    end

    @board.show_board
    display

  end


  private




  def make_move(input)
    move = input[0]
    position = [input[1].to_i, input[2].to_i]
    tile = @board[position.first][position.last]

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
    Board.valid_position?(nums)
  end

  def display
    display_board = @board.create_display_screen

    puts "_||#{(0..8).to_a.join("|")}||"
    display_board.each.with_index do |row, idx|
      puts "#{idx}||" + row.join("|") + "||"
    end
  end



end

if __FILE__ == $PROGRAM_NAME
  game = MineSweeper.new
  game.play
end
