require_relative 'serializable/base_serializable'

# Saves and loads games based on prompts from game menu
require 'json'

class GameManager
  include BaseSerializable
  include GameMenu

  SAVE_FILE = 'save_game.json'

  def self.save(game)
    File.open(SAVE_FILE, 'w') { |file| file.write(game.serialize) }
    puts 'Game Saved!'
  end

  def self.load
    return unless File.exist?(SAVE_FILE)

    saved_data = File.read(SAVE_FILE)
    game = PlayGame.new
    game.unserialize(saved_data)
    puts 'Game loaded!'
    game
  end
end
