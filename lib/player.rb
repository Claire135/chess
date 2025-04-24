# frozen_string_literal: true

require_relative 'pieces/pieces'

class Player
  attr_accessor :name, :score, :color

  def initialize(name, color)
    @name = name
    @score = 0
    @color = color
  end

  def player_piece_match?(piece)
    @color == piece.color
  end

  def increment_score(captured_piece)
    @score += piece_value(captured_piece)
  end

  def decrement_score(captured_piece)
    @score -= piece_value(captured_piece)
  end

  private

  def piece_value(captured_piece)
    case captured_piece
    when Pawn
      1
    when Knight, Bishop
      3
    when Castle
      5
    when Queen
      9
    else
      0
    end
  end
end
