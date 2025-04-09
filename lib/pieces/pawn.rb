require_relative 'pieces'

class Pawn < Pieces
  def generate_valid_moves
    x, y = @position
    [[x + 1, y]]
  end
end
