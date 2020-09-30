require_relative "../board/board"
require_relative "../cursor/cursor"
require 'colorize'
require 'colorized_string'

class Display
  attr_reader :board, :cursor

  def initialize
    @board = Board.new
    @cursor = Cursor.new([0,0],@board)
    @selected = nil
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
        if [i,idx] == @selected
          space.on_red
        elsif [i,idx] == @cursor.cursor_pos
          space.on_yellow
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

      puts "#{i} #{symbols.join(" ")}"
    end
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
    toggle_selected
    render
    return @cursor.cursor_pos
  end

  private
  def toggle_selected
    @selected = @cursor.cursor_pos
  end
end