require_relative 'pieces'

class King < Pieces
  def generate_valid_moves(board)
    row, col = @position
    directions = [
      [1, 0], [-1, 0], [0, 1], [0, -1],
      [1, 1], [1, -1], [-1, 1], [-1, -1]
    ]

    directions.map { |dr, dc| [row + dr, col + dc] }.select do |r, c|
      on_board?(r, c) &&
        (board.empty_at?(r, c) || board.enemy_piece_at?(r, c, @color))
    end
  end

  def on_board?(row, col)
    row.between?(0, 7) && col.between?(0, 7)
  end
end
