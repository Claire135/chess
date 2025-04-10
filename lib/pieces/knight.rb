require_relative 'pieces'

class Knight < Pieces
  def directions
    [
      [1, 2], [2, 1], [2, -1], [1, -2],
      [-1, -2], [-2, -1], [-2, 1], [-1, 2]
    ]
  end
end
