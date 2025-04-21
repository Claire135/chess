# frozen_string_literal: true

# subclass of Pieces

require_relative 'pieces'

class Bishop < Pieces
  def valid_move?(board, start_coordinates, end_coordinates)
    if diagonal_move?(start_coordinates, end_coordinates) &&
       board.path_clear?(start_coordinates, end_coordinates) &&
       (board.empty_at?(end_coordinates) || board.enemy_at?(end_coordinates, color))
      true
    else
      false
    end
  end
end
