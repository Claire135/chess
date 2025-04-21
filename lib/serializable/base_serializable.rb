# frozen_string_literal: true

# Serializes and unserializes game data
require_relative 'board_serializable'
require_relative 'pieces_serializable'
require_relative 'play_game_serializable'
require_relative 'player_serializable'
require_relative 'win_conditions_serializable'

module BaseSerializable
  def serialize
    JSON.dump(to_h)
  end
end
