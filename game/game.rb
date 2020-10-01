require_relative "../display/display.rb"
require_relative "../player/player.rb"

class Game

  def initialize(players)
    @board = Board.new
    @display = Display.new(@board)
    @players = {Player1 = players[0], Player2 = players[1]}
    @current_player = Player1
  end

  def play
  end

  def notify_players
  end

  def swap_turn!
  end

  attr_reader :board, :display
end