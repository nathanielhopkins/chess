require_relative "../player.rb"

class HumanPlayer < Player

  def make_move(board)
    input = nil
    @display.render
    until input != nil
      system('clear')
      @display.render
      input = @display.cursor.get_input
    end
    system('clear')
    @display.render
    return input
  end
end