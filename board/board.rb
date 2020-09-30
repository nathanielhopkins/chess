require_relative "../piece/piece_requires"

class Board

  def initialize
    @sentinel = NullPiece
    @rows = Array.new(8) {Array.new(8)}
    set_board
  end

  def set_board
    #set white
    (0..7).each {|y| self[[6,y]] = Pawn.new(:white,self,[6,y])}
    self[[7,0]] = Rook.new(:white,self,[7,0])
    self[[7,1]] = Knight.new(:white,self,[7,1])
    self[[7,2]] = Bishop.new(:white,self,[7,2])
    self[[7,3]] = Queen.new(:white,self,[7,3])
    self[[7,4]] = King.new(:white,self,[7,4])
    self[[7,5]] = Bishop.new(:white,self,[7,5])
    self[[7,6]] = Knight.new(:white,self,[7,6])
    self[[7,7]] = Rook.new(:white,self,[7,7])
    #set black
    (0..7).each {|y| self[[1,y]] = Pawn.new(:black,self,[1,y])}
    self[[0,0]] = Rook.new(:black,self,[0,0])
    self[[0,1]] = Knight.new(:black,self,[0,1])
    self[[0,2]] = Bishop.new(:black,self,[0,2])
    self[[0,3]] = Queen.new(:black,self,[0,3])
    self[[0,4]] = King.new(:black,self,[0,4])
    self[[0,5]] = Bishop.new(:black,self,[0,5])
    self[[0,6]] = Knight.new(:black,self,[0,6])
    self[[0,7]] = Rook.new(:black,self,[0,7])
    # #set nullpieces
    # (2..5).each do |x|
    #   (0..7).each do |y|
    #     self[[x,y]] = @sentinel
    #   end
    # end
  end

  def [](pos)
    x,y = pos
    @rows[x][y]
  end

  def []=(pos,value)
    x,y = pos
    @rows[x][y] = value
  end

  def move_piece(start_pos, end_pos)
    raise "No piece here" if self[start_pos].nil?
    raise "Cannot move here" if valid_pos?(end_pos) == false
    piece = self[start_pos]
    piece.pos = end_pos
    add_piece(piece, end_pos)
    self[start_pos] = nil
  end

  def valid_pos?(pos)
    x,y = pos
    x.between?(0,7) && y.between?(0,7)
  end

  def add_piece(piece,pos)
    self[pos] = piece
    piece.pos = pos
  end

  def checkmate?(color)
  end

  def in_check?(color)
  end

  def find_king(color)
    search = @rows.flatten
    king_raw = nil
    search.each_with_index do |square, i|
      if square
        king_raw = i if square.symbol == :K && square.color == color
      end
    end
    x = king_raw / 8
    y = king_raw - (8*x)
    king_pos = [x,y]
  end

  def pieces
    pieces = []
    @rows.flatten.each {|piece| pieces << piece if piece}
    pieces
  end

  def dup
  end

  def move_piece!(color,start_pos,end_pos)
  end
  attr_reader :rows
end