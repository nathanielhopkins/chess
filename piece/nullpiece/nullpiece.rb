require_relative "../piece.rb"
require "singleton"

class NullPiece < Piece
  include Singleton

  private
  def initialize
    super(:null,nil,nil)
  end

  public
  def symbol
    :_
  end

  def moves
    []
  end
  attr_reader :color
end