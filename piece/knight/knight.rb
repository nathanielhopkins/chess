require_relative "../piece"
require_relative "../modules/stepable"

class Knight < Piece
  include Stepable
  KNIGHT_MOVES = [[-2,-1],[-2,1],[-1,-2],[-1,2],[1,-2],[1,2],[2,-1],[2,1]]
  def symbol
    :N
  end

  protected
  def move_diffs
    KNIGHT_MOVES
  end
end