# instance variables @color, @alive, @position and @symbol added to Piece Class
# set up Knight Class to inherit variables and methods from Piece Superclass
# Piece Class contains generic methods specific

class Pieces
  attr_accessor :color, :position, :alive, :symbol, :name

  def initialize(color, position, symbol, name)
    @color = color
    @alive = true
    @position = position
    @symbol = symbol
    @name = name
  end

  def valid_move?(x, y)
    generate_valid_moves.include?([x, y])
  end
end
