# frozen_string_literal: true

# Launches the game

require_relative 'play_game'

class GameLauncher
  def self.start
    new_game = PlayGame.new
    new_game.play
  end
end
