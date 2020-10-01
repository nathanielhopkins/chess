module Slideable
  private 
  HORIZONTAL_DIRS = [[-1,0],[1,0],[0,-1],[0,1]]
  DIAGONAL_DIRS = [[-1,-1],[-1,1],[1,-1],[1,1]]

  public
  def horizontal_dirs
    HORIZONTAL_DIRS
  end

  def diagonal_dirs
    DIAGONAL_DIRS
  end

  def moves #returns array of positions piece can move to
    moves = []
    move_dirs.each do |move_dir|
      dx,dy = move_dir
      moves_in_dir = grow_unblocked_moves_in_dir(dx,dy)
      moves += moves_in_dir if !moves_in_dir.empty?
    end
    moves
  end

  def move_dirs #overwritten by subclass
    super
  end

  def grow_unblocked_moves_in_dir(dx,dy)
    unblocked_moves = []
    x,y = @pos
    next_move = [(x + dx), (y + dy)]
    if @board.valid_pos?(next_move) && @board[next_move].class == NullPiece
      x += dx
      y += dy
    end
    until @board.valid_pos?([x,y]) == false || @board[[x,y]].class != NullPiece
      unblocked_moves << [x,y]
      x += dx
      y += dy
    end
    possible_enemy = [x,y]
    if @board.valid_pos?(possible_enemy) && @board[possible_enemy].color != @color
      unblocked_moves << possible_enemy 
    end
    unblocked_moves
  end

end