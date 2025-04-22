# frozen_string_literal: true

require_relative 'move_context'
require_relative 'player'
require_relative 'board'
require_relative 'win_conditions'
require_relative 'ui_able'
require_relative 'player_input'

class PlayGame
  include UIable
  include PlayerInput

  def initialize
    @chess_board = Board.new
    @white_player = Player.new('White Player', 'white')
    @black_player = Player.new('Black Player', 'black')
    @current_player = @white_player
    @move = MoveContext.new(@chess_board)
    @win = WinConditions.new(@chess_board)
  end

  def start_game
    puts '[PlayGame] Running start_game'
    game_start_or_load_prompt
  end

  def play_game
    @chess_board.display_board
    loop do
      @win.check?          # <- always update check state
      break if @win.checkmate?

      turn_message
      move_piece
      @win.check?          # <- re-evaluate after move
      check_message
      @chess_board.display_board
      switch_players
    end
    end_game
    play_again_prompt
  end

  def save_game
    # Open a file to save the game using Marshal
    File.open('saved_game.marshal', 'wb') do |file|
      Marshal.dump(self, file) # Serialize the object to the file
    end
    puts 'Game saved!'
  end

  def load_game
    loaded_game = PlayGame.load
    if loaded_game
      puts 'Game loaded!'
      loaded_game.play_game
      exit
    else
      puts 'No saved game found!'
    end
  end

  private

  def self.load
    if File.exist?('saved_game.marshal')
      File.open('saved_game.marshal', 'rb') do |file|
        Marshal.load(file)
      end
    else
      nil
    end
  end

  def end_game
    checkmate_message if @win.checkmate?
    score_message
  end

  def move_piece
    @move.start_coordinate = request_and_process_start_coordinate(@current_player, @chess_board, @move)
    @move.set_current_piece
    @move.end_coordinate = request_and_process_end_coordinate(@current_player, @chess_board, @move)

    was_capture = @chess_board.captured_piece_at(@move.end_coordinate)
    if was_capture
      capture_piece
      score_message
      capture_message(@move)
    end

    @move.handle_movement
  end

  def capture_piece
    @move.handle_capture
    handle_capture_scores(@white_player)
    handle_capture_scores(@black_player)
  end

  def switch_players
    @current_player = @current_player == @white_player ? @black_player : @white_player
  end

  def handle_capture_scores(player)
    return if @move.captured_piece.nil?

    if player.color == @move.captured_piece.color
      player.decrement_score(@move.captured_piece)
    else
      player.increment_score(@move.captured_piece)
    end
  end
end
