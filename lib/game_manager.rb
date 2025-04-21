require_relative 'serializable/base_serializable'
require 'json'

class GameManager
  include BaseSerializable
  include GameMenu

  SAVE_FILE = 'save_game.json'

  def self.save(game)
    File.open(SAVE_FILE, 'w') { |file| file.write(game.serialize) }
    puts 'Game Saved!'
  end

  def self.load(filename = SAVE_FILE)
    serialized_data = File.read(filename)
    puts "DEBUG - Serialized Data: #{serialized_data}" # Add this line
    hash = JSON.parse(serialized_data) # or Marshal.load, depending on your serializer
    PlayGame.from_h(hash)
  end
end
