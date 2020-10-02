require_relative "../display/display.rb"
require_relative "../player/human_player/human_player.rb"

class Game

  def initialize
    @board = Board.new
    @display = Display.new(@board)
    @players = {:white => HumanPlayer.new(:white,@display), :black => HumanPlayer.new(:black,@display)}
    @current_player = @players[:white]
  end

  def play
  end
  
  def take_turn
    @display.render
    puts "Please select a piece"
    start_pos = @current_player.make_move(@board)
    puts "Please select a valid move."
    end_pos = @current_player.make_move(@board)
    @board.move_piece(start_pos,end_pos)
    @display.cursor.reset_cursor
    system("clear")
    @display.render
  rescue
    raise "Not a valid move. (from game)"
  end

  def notify_players
  end

  def swap_turn!
    if @current_player == @players[:white]
      @current_player = @players[:black]
    else
      @current_player = @players[:white]
    end
  end

  attr_reader :board, :display, :players, :current_player
end