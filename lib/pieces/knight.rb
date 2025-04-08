require_relative 'pieces'

class Knight < Pieces
  def valid_move?(x, y)
    x, y = @current_position
    moves = generate_knight_moves(x, y)
    filter_valid_moves(moves)
  end

  private

  def generate_knight_moves(x, y)
    [
      [x + 1, y + 2], [x + 2, y + 1], [x + 2, y - 1], [x + 1, y - 2],
      [x - 1, y - 2], [x - 2, y - 1], [x - 2, y + 1], [x - 1, y + 2]
    ]
  end
end
