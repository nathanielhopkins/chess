class Piece

  def initialize(color,board,pos)
    @color = color
    @board = board
    @pos = pos
  end

  def to_s
    symbol.to_s
  end

  def empty?
  end

  def valid_moves
  end

  def pos=(val)
    @pos = val
  end

  def symbol
    piece.symbol
  end

  def move_into_check?(end_pos)
  end
  attr_reader :pos, :color
end