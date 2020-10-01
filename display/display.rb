require_relative "../board/board"
require_relative "../cursor/cursor"
require 'colorize'
require 'colorized_string'

class Display
  attr_reader :board, :cursor

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0],@board)
  end

  def render
    puts "  a b c d e f g h"
    @board.rows.each_with_index do |row, i|
      symbols = row.map do |piece| 
        if piece
          piece.to_s.colorize(piece.color)
        else
          '_'.colorize(:light_blue)
        end
      end
      symbols = symbols.each_with_index.map do |space, idx|
        if [i,idx] == @cursor.cursor_pos
          if @cursor.selected == true
            space.on_red
          else
            space.on_yellow
          end
        elsif i.even?
          if idx.even?
            space.on_light_blue
          else
            space.on_blue
          end
        else
          if idx.even?
            space.on_blue
          else
            space.on_light_blue
          end
        end
      end

      puts "#{8 - i} #{symbols.join(" ")} #{8 - i}"
    end
     puts "  a b c d e f g h"
  end

  def get_cursor_input
    input = nil
    render
    until input != nil
      system('clear')
      render
      input = @cursor.get_input
    end
    system('clear')
    render
    return @cursor.cursor_pos
  end
end