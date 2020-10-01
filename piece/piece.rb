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
    valid_moves = moves.select {|move| move_into_check?(move) == false}
    valid_moves
  end

  def pos=(val)
    @pos = val
  end

  def symbol
    piece.symbol
  end

  def move_into_check?(end_pos)
    duped = @board.dup
    duped.move_piece!(@pos,end_pos)
    duped.in_check?(@color)
  end
  attr_reader :pos, :color
end