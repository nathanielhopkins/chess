require_relative "../piece/piece_requires"

class Board

  def initialize
    @sentinel = NullPiece.instance
    @rows = Array.new(8) {Array.new(8)}
    set_board
  end

  private
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
    #set nullpieces
    (2..5).each do |x|
      (0..7).each do |y|
        self[[x,y]] = @sentinel
      end
    end
  end

  def add_piece(piece,pos)
    self[pos] = piece
    piece.pos = pos
  end

  def pieces
    pieces = []
    @rows.flatten.each {|piece| pieces << piece if piece}
    pieces
  end

  def opponent(color)
    color == :white ? :black : :white
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

  public
  def [](pos)
    x,y = pos
    @rows[x][y]
  end

  def []=(pos,value)
    x,y = pos
    @rows[x][y] = value
  end

  def move_piece(start_pos, end_pos)
    raise "No piece here" if self[start_pos] == @sentinel
    raise "Cannot move here" if valid_pos?(end_pos) == false
    piece = self[start_pos]
    raise "Cannot move here, would place you in check." if piece.move_into_check?(end_pos)
    if piece.valid_moves.include?(end_pos)
      piece.pos = end_pos
      add_piece(piece, end_pos)
      self[start_pos] = @sentinel
    else
      raise "Not a valid move."
    end
  end

  def valid_pos?(pos)
    x,y = pos
    x.between?(0,7) && y.between?(0,7)
  end

  def checkmate?(color)
    player_pieces = pieces.select {|piece| piece.color == color}
    no_valid_moves = player_pieces.none? {|piece| !piece.valid_moves.empty? }
    in_check?(color) && no_valid_moves
  end

  def in_check?(color)
    opponent_color = opponent(color)
    enemy_pieces = pieces.select {|piece| piece.color == opponent_color}
    king_pos = find_king(color)
    enemy_pieces.each do |enemy|
      return true if enemy.moves.any? {|move| move == king_pos}
    end
    return false
  end

  def dup
    dup = Board.new
    dup.deep_copy(@rows)
    dup
  end

  def deep_copy(rows)
    @rows.each_with_index do |row, row_idx|
      row.each_with_index do |col, col_idx|
        object = rows[row_idx][col_idx]
        if object.class == NullPiece
          self[[row_idx,col_idx]] = @sentinel
        else
          self[[row_idx,col_idx]] = object.class.new(object.color,self,object.pos)
        end
      end
    end
  end

  def move_piece!(start_pos,end_pos)
    raise "No piece here" if self[start_pos] == @sentinel
    raise "Cannot move here" if valid_pos?(end_pos) == false
    piece = self[start_pos]
    piece.pos = end_pos
    add_piece(piece, end_pos)
    self[start_pos] = @sentinel
  end
  attr_reader :rows
end