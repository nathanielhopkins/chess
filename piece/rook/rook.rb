require_relative "../piece"
require_relative "../modules/slideable"

class Rook < Piece
  include Slideable
  
  def symbol 
    :R
  end

  def move_dirs
    # protected
    move_dirs = horizontal_dirs
  end
end