require_relative "../display/display.rb"
require_relative "../player/human_player/human_player.rb"

class Game
  attr_reader :board, :display, :players, :current_player
  def initialize
    @board = Board.new
    @display = Display.new(@board)
    @players = {:white => HumanPlayer.new(:white,@display), :black => HumanPlayer.new(:black,@display)}
    @current_player = @players[:white]
  end

  def play
    system("clear")
    notify_players
    until @board.checkmate?(current_player.color)
      take_turn
      swap_turn!
      notify_players
    end
    swap_turn!
    @display.render
    puts "#{@current_player.color.to_s.capitalize} Wins!!"
  end

 private 
  def inspect
    puts
  end

  def continue
    @display.cursor.get_input
  end

  def take_turn
    @display.render
    puts "#{@current_player.color.to_s.capitalize}, please select a piece"
    continue
    start_pos = @current_player.make_move(@board)
    unless @board[start_pos].color == @current_player.color
      raise ArgumentError.new "Not your piece."
    end
    puts "Please select a valid move for #{@board[start_pos].class}."
    continue
    end_pos = @current_player.make_move(@board)
    unless @board[start_pos].valid_moves.include?(end_pos)
      if @board[start_pos].move_into_check?(end_pos)
        raise ArgumentError.new "Cannot leave your king in check."
      end
      raise ArgumentError.new "Not a valid move for that piece."
    end
    @board.move_piece(start_pos,end_pos)
    @display.cursor.reset_cursor
    system("clear")
    @display.render
  rescue ArgumentError => e
    puts e.message
    continue
    retry
  end

  def notify_players
    system("clear")
    player = @current_player.color
    name = player.to_s.capitalize
    return puts "#{name} is in checkmate." if @board.checkmate?(player)
    if @board.in_check?(player)
      puts "#{name} is in check."
    end
    puts "#{name}'s turn. Press any key to continue."
    continue
  end

  def swap_turn!
    if @current_player == @players[:white]
      @current_player = @players[:black]
    else
      @current_player = @players[:white]
    end
  end
end