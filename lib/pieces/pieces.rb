class Pieces
  attr_accessor :color, :position, :alive, :symbol

  def initialize(color, position, symbol)
    @color = color
    @alive = true
    @position = position
    @symbol = symbol
  end

  def move_to(new_position)
    @position = new_position
  end

  # generic helper methods for determining valid moves of each individual piece
  def filter_valid_moves(moves)
    moves.select { |new_move_x, new_move_y| valid_coordinates?(new_move_x, new_move_y) }
  end

  def valid_coordinates?(x, y)
    x.between?(0, 7) && y.between?(0, 7)
  end
end
