# frozen_string_literal: true

require_relative 'pieces/pieces'
require_relative 'serializable/base_serializable'
require_relative 'serializable/player_serializable'

class Player
  extend PlayerSerializable
  include BaseSerializable
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

  def to_h
    {
      'name' => @name,
      'score' => @score,
      'color' => @color
    }
  end

  def self.from_h(hash)
    raise ArgumentError, 'Expected a hash but got nil' if hash.nil?

    Player.new(hash['name'], hash['color'])
    player_data = JSON.parse(hash['@current_player']['data'])
    game.instance_variable_set(:@current_player, Player.from_h(player_data))
    white_data = JSON.parse(hash['@white_player']['data'])
    game.instance_variable_set(:@white_player, Player.from_h(white_data))

    black_data = JSON.parse(hash['@black_player']['data'])
    game.instance_variable_set(:@black_player, Player.from_h(black_data))
  end
end
