require_relative "../player.rb"

class HumanPlayer < Player

  def make_move(board)
    input = @display.get_cursor_input
  end
end