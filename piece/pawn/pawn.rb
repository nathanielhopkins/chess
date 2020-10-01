require_relative "../piece"

class Pawn < Piece

  def symbol
    :p
  end

  def moves
    forward_steps + side_attacks
  end

  def at_start_row?
    if @color == :white
      @pos[0] == 6
    else
      @pos[0] == 1
    end
  end

  def forward_dir #returns 1 or -1
    if @color == :white
      return -1
    else
      return 1
    end
  end

  def forward_steps
    x,y = @pos
    dx = forward_dir
    if at_start_row?
      return [[(x+dx),y],[(x+(2*dx)),y]]
    else
      return [[(x+dx),y]]
    end
  end
  
  def side_attacks
    x,y = @pos
    dx = x + forward_dir 
    attacks = [[dx,(y-1)],[dx,(y+1)]]
    attacks.select {|attack| @board[attack] != nil && @board[attack].color != @color}
  end
end