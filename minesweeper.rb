require './board'
require 'yaml'

class MineSweeper

  attr_reader :board

  def initialize
    @board = Board.new
  end

  def play
    output = true
    start_time = Time.now
    puts "Press 'l' to load previous game or 'n' to start a new game"
    if gets.chomp.downcase == 'l'
      @board = YAML::load(File.read('saved-game.txt'))
    end

    until output == false || @board.game_won?
      display
      input = read_input
      if input.first == 's'
        puts "Game saved. Please load on next start to continue"
        save
        return
      end
      output = make_move(input)
    end

    if @board.game_won?
      puts "You Win! Congrats!"
      end_time = Time.now
      total_time = end_time - start_time

      puts "Total Time: #{total_time} Seconds"

    else
      puts "Sorry buddy..."
    end

    @board.show_board
    display
  end

  private

  def save
    serialized_game = @board.to_yaml
    f = File.open("saved-game.txt", "w")
    f.puts serialized_game
    f.close
  end


  def make_move(input)
    move = input.first
    position = [input[1].to_i, input[2].to_i]
    tile = @board[position.first][position.last]

    tile.move(move)
  end

  def read_input
    while true
      puts "Choose square to reveal(r), flag(f), or unflag(u) ex: f 1 2"
      puts "Please press 's' to save and quit game."
      input = gets.chomp.downcase.split
      break if valid_input?(input)
      puts "Please provide proper input"
    end

    input
  end

  def valid_input?(input)
    return true if input.first == 's'
    return false unless input.count == 3

    choice = input[0]
    nums = [input[1].to_i, input[2].to_i]

    (choice == 'f' || choice == 'u' || choice == "r") &&
    Board.valid_position?(nums)
  end

  def display
    display_board = @board.create_display_screen

    puts "_||#{(0...Board::BOARD_SIZE).to_a.join("|")}||"
    display_board.each.with_index do |row, idx|
      puts "#{idx}||" + row.join("|") + "||"
    end
  end



end

if __FILE__ == $PROGRAM_NAME
  game = MineSweeper.new
  game.play
end
