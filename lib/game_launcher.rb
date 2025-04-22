# frozen_string_literal: true

# Launches the game

require_relative 'play_game'

class GameLauncher
  def self.start
    puts '[GameLauncher] Starting...'
    new_game = PlayGame.new
    puts '[GameLauncher] Game initialized'
    new_game.start_game
  end
end
