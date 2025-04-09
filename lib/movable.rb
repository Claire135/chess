module Movable
  def validate_end_coordinate(end_coordinate, current_piece)
    x, y = end_coordinate
    current_piece.valid_move?(x, y)
  end

  def find_matching_piece(start_coordinate)
    all_pieces.find { |piece| piece.position == start_coordinate }
  end

  def all_pieces
    @white_pieces + @black_pieces
  end

  def update_board_position(piece, old_x, old_y, new_x, new_y)
    @board[old_x][old_y] = nil
    @board[new_x][new_y] = piece
  end
end
