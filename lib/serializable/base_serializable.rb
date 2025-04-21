require_relative 'player_serializable'
require_relative 'board_serializable'
require_relative 'win_conditions_serializable'
require_relative 'play_game_serializable'

# Serialises and unserialises game data
# Centralises all serialisable game data
# as each class needed it's own serialise method #to_h

require 'json'

module BaseSerializable
  def serialize
    obj = {}

    #
    instance_variables.map do |var|
      obj[var] = if (value = instance_variable_get(var)).respond_to?(:to_h)
                   value.to_h
                 else
                   value
                 end
    end

    JSON.dump obj
  end

  def unserialize(string)
    obj = JSON.parse(string)
    obj.each do |var, val|
      instance_variable_set(var.to_sym, val)
    end
  end
end
