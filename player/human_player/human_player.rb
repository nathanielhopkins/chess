require_relative "../player.rb"
class HumanPlayer < Player

  def make_move(board)
    piece = @display.get_cursor_input
    move = @display.get_cursor_input
    if board[piece].color == @color
      board.move_piece(piece,move) 
    else
      raise "Not your piece"
    end
    @display.render
  rescue
    puts "Not a valid move. Press Enter to continue."
    retry
  end
end