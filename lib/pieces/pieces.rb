# instance variables @color, @alive, @position and @symbol added to Piece Class
# set up Knight Class to inherit variables and methods from Piece Superclass
# Piece Class contains generic methods specific

class Pieces
  attr_accessor :color, :position, :alive, :symbol, :name, :move_count

  def initialize(color, position, symbol, name)
    @color = color
    @alive = true
    @position = position
    @symbol = symbol
    @name = name
    @move_count = 0
  end

  def on_board?(row, col)
    row.between?(0, 7) && col.between?(0, 7)
  end

  def count_moves
    @move_count += 1
  end

  # valid moves
  def horizontal_move?(start_coordinates, end_coordinates)
    start_row, start_col = start_coordinates
    end_row, end_col = end_coordinates
    start_row == end_row
  end

  def vertical_move?(start_coordinates, end_coordinates)
    start_row, start_col = start_coordinates
    end_row, end_col = end_coordinates
    start_col == end_col
  end
end
