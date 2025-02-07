require_relative "../piece"
require_relative "../modules/slideable"

class Rook < Piece
  include Slideable
  
  def symbol 
    :R
  end

  protected
  def move_dirs
    move_dirs = horizontal_dirs
  end
end