require_relative 'pieces'

class Knight < Pieces
  def valid_move?(board, start_coordinates, end_coordinates)
    if l_shape_move?(start_coordinates, end_coordinates) &&
       (board.empty_at?(end_coordinates) || board.enemy_at?(end_coordinates, color))
      true
    else
      false
    end
  end

  def l_shape_move?(start_coordinates, end_coordinates)
    start_row, start_col = start_coordinates
    end_row, end_col = end_coordinates

    if (end_row - start_row == 2 && end_col - start_col == 1) ||
       (end_row - start_row == 2 && end_col - start_col == -1) ||
       (end_row - start_row == 1 && end_col - start_col == 2) ||
       (end_row - start_row == 1 && end_col - start_col == -2) ||
       (end_row - start_row == -2 && end_col - start_col == -1) ||
       (end_row - start_row == -2 && end_col - start_col == 1) ||
       (end_row - start_row == -1 && end_col - start_col == -2) ||
       (end_row - start_row == -1 && end_col - start_col == 2)
      true
    else
      false
    end
  end
end
