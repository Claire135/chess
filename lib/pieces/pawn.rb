# frozen_string_literal: true

require_relative 'pieces'

# no en_passant

class Pawn < Pieces
  def valid_move?(board, start_coordinates, end_coordinates)
    # Check if the move is 2 steps forward (first move only), path is clear, and the end square is empty
    if move_two_steps_forward?(start_coordinates, end_coordinates) &&
       board.empty_at?(end_coordinates) &&
       board.path_clear?(start_coordinates, end_coordinates)
      return true
    end

    # Check if the move is 1 step forward and the end square is empty
    if move_one_step_forward?(start_coordinates, end_coordinates) &&
       board.empty_at?(end_coordinates)
      return true
    end

    # Check if the move is a valid diagonal capture
    if move_one_step_diagonally?(board, start_coordinates, end_coordinates) &&
       board.enemy_at?(end_coordinates, @color) # Ensure that the piece being captured is an enemy
      return true
    end

    # If none of the conditions are met, the move is invalid
    false
  end

  def move_one_step_forward?(start_coordinates, end_coordinates)
    start_row, start_col = start_coordinates
    end_row, end_col = end_coordinates

    return false unless end_col == start_col

    @color == 'black' ? end_row - start_row == 1 : start_row - end_row == 1
  end

  def move_two_steps_forward?(start_coordinates, end_coordinates)
    start_row, start_col = start_coordinates
    end_row, end_col = end_coordinates

    return false unless @move_count.zero? && end_col == start_col

    @color == 'black' ? end_row - start_row == 2 : start_row - end_row == 2
  end

  def move_one_step_diagonally?(board, start_coordinates, end_coordinates)
    start_row, start_col = start_coordinates
    end_row, end_col = end_coordinates

    row_diff = end_row - start_row
    col_diff = (end_col - start_col).abs

    if @color == 'black'
      row_diff == 1 && col_diff == 1 && board.enemy_at?(end_coordinates, color)
    else
      row_diff == -1 && col_diff == 1 && board.enemy_at?(end_coordinates, color)
    end
  end
end
