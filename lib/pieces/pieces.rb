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

  def valid_move?(row, col, board)
    generate_valid_moves(board).include?([row, col])
  end

  def generate_valid_moves(board)
    row, col = @position

    directions.map { |dr, dc| [row + dr, col + dc] }.select do |r, c|
      on_board?(r, c) && (board.empty_at?(r, c) || board.enemy_piece_at?(r, c, @color))
    end
  end

  def on_board?(row, col)
    row.between?(0, 7) && col.between?(0, 7)
  end

  def count_moves
    @move_count += 1
  end
end
