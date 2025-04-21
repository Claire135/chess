# frozen_string_literal: true

require_relative 'pieces'

class Castle < Pieces
  def valid_move?(board, start_coordinates, end_coordinates)
    if (horizontal_move?(start_coordinates, end_coordinates) ||
      vertical_move?(start_coordinates, end_coordinates)) &&
       board.path_clear?(start_coordinates, end_coordinates) &&
       (board.empty_at?(end_coordinates) || board.enemy_at?(end_coordinates, color))
      true
    else
      false
    end
  end
end
