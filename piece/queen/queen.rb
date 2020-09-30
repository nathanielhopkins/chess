require_relative "../piece"
require_relative "../modules/slideable"

class Queen < Piece
  include Slideable
  
  def symbol 
    :Q
  end

  def move_dirs 
    # protected
    move_dirs = horizontal_dirs + diagonal_dirs
  end
end