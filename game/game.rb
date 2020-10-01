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

  def notify_players
  end

  def swap_turn!
  end

  attr_reader :board, :display, :players
end