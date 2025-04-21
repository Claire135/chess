# frozen_string_literal: true

require_relative 'pieces'
require_relative 'castle'

class King < Pieces
  def valid_move?(board, start_coordinates, end_coordinates)
    if (move_one_step_horizontally?(start_coordinates, end_coordinates) ||
      move_one_step_vertically?(start_coordinates, end_coordinates) ||
      move_one_step_diagonally?(start_coordinates, end_coordinates) ||
      castlable?(start_coordinates, end_coordinates)) &&
       (board.empty_at?(end_coordinates) || board.enemy_at?(end_coordinates, color))
      true
    else
      false
    end
  end

  def castlable?(start_coordinates, end_coordinates)
    # king.move_count.zero? &&
    # castle.move_count.zero? &&
    # board.enemy_at?(end_coordinates, color) == false &&
    # board.path_clear?(start_coordinates, end_coordinates)
  end

  def possible_moves(start_coordinates, end_coordinates)
    move_one_step_horizontally?(start_coordinates, end_coordinates) ||
      move_one_step_vertically?(start_coordinates, end_coordinates) ||
      move_one_step_diagonally?(start_coordinates, end_coordinates)
  end

  def move_one_step_horizontally?(start_coordinates, end_coordinates)
    row_diff = (end_coordinates[0] - start_coordinates[0]).abs
    col_diff = (end_coordinates[1] - start_coordinates[1]).abs

    row_diff.zero? && col_diff == 1
  end

  def move_one_step_vertically?(start_coordinates, end_coordinates)
    row_diff = (end_coordinates[0] - start_coordinates[0]).abs
    col_diff = (end_coordinates[1] - start_coordinates[1]).abs

    col_diff.zero? && row_diff == 1
  end

  def move_one_step_diagonally?(start_coordinates, end_coordinates)
    row_diff = (end_coordinates[0] - start_coordinates[0]).abs
    col_diff = (end_coordinates[1] - start_coordinates[1]).abs

    row_diff == 1 && col_diff == 1
  end
end
