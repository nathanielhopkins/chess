require_relative "../piece"
require_relative "../modules/slideable"

class Queen < Piece
  include Slideable
  
  def symbol 
    :Q
  end

  protected
  def move_dirs 
    move_dirs = horizontal_dirs + diagonal_dirs
  end
end