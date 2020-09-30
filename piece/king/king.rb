require_relative "../piece"
require_relative "../modules/stepable"

class King < Piece
  include Stepable
  HORIZONTAL_DIRS = [[-1,0],[1,0],[0,-1],[0,1]]
  DIAGONAL_DIRS = [[-1,-1],[-1,1],[1,-1],[1,1]]
  def symbol
    :K
  end

  protected
  def move_diffs
    HORIZONTAL_DIRS + DIAGONAL_DIRS
  end
end