require "byebug"
module Stepable

  def moves
    moves = []
    move_dirs = move_diffs
    x,y = self.pos
    move_dirs.each do |move_dir|
      dx,dy = move_dir
      move = [(x+dx),(y+dy)]
      if @board.valid_pos?(move)
        if @board[move] == nil
          moves << move
        elsif @board[move].color != @color
          moves << move
        end
      end
    end
    moves
  end

  private
  def move_diffs
    super
  end
end