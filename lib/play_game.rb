# frozen_string_literal: true

require_relative 'move_context'
require_relative 'player'
require_relative 'board'
require_relative 'win_conditions'
require_relative 'ui_able'
require_relative 'game_menu'
require_relative 'game_manager'
require_relative 'serializable/base_serializable'
require_relative 'serializable/play_game_serializable'

class PlayGame
  extend PlayGameSerializable
  include UIable
  include GameMenu
  include BaseSerializable

  def initialize
    @chess_board = Board.new
    @white_player = Player.new('White Player', 'white')
    @black_player = Player.new('Black Player', 'black')
    @current_player = @white_player
    @move = MoveContext.new(@chess_board)
    @win = WinConditions.new(@chess_board)
  end

  def play_game
    game_start_or_load_prompt

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
      save_or_load_prompt
    end
    end_game
    play_again_prompt
  end

  def save_game
    File.write('save_game.json', JSON.dump(to_h))
    puts 'Game saved!'
  end

  def load_game
    hash = JSON.parse(File.read('save_game.json'))
    loaded_game = PlayGameSerializable.from_h(hash)
    copy_game_state_from(loaded_game)
    puts 'Game loaded!'
  end

  def copy_game_state_from(other)
    @chess_board = other.chess_board
    @white_player = other.white_player
    @black_player = other.black_player
    @current_player = other.current_player
    @win = other.win
    @move = MoveContext.new(@chess_board) # Re-establish context
  end

  def to_h
    {
      'chess_board' => @chess_board.to_h,
      'white_player' => @white_player.to_h,
      'black_player' => @black_player.to_h,
      'current_player' => @current_player.to_h,
      'win' => @win.to_h
    }
  end

  def self.from_h(hash)
    PlayGame.new.tap do |game|
      game.instance_variable_set(:@chess_board, Board.from_h(hash['chess_board']))
      game.instance_variable_set(:@white_player, Player.from_h(hash['white_player']))
      game.instance_variable_set(:@black_player, Player.from_h(hash['black_player']))

      # Check if @current_player exists before accessing its data
      if hash['@current_player']
        game.instance_variable_set(:@current_player, Player.from_h(hash['@current_player']))
      else
        # Set a default player or raise an error if this is critical
        game.instance_variable_set(:@current_player, Player.new(name: 'White Player', color: 'white'))
      end

      game.instance_variable_set(:@win, WinConditions.from_h(hash['win'], game.chess_board))
      game.instance_variable_set(:@move, MoveContext.new(game.chess_board))
    end
  end

  private

  def end_game
    checkmate_message if @win.checkmate?
    score_message
  end

  def move_piece
    @move.set_start_coordinate
    @move.set_current_piece
    @move.set_end_coordinate
    if @move.current_piece.valid_move?(@chess_board, @move.start_coordinate, @move.end_coordinate) &&
       @current_player.player_piece_match?(@move.current_piece)

      was_capture = @chess_board.captured_piece_at(@move.end_coordinate)
      if was_capture
        capture_piece
        score_message
      end

      @move.handle_movement
    else
      puts 'Invalid move, pick another!' # THIS NEEDS AN ERROR LOOP!!!!
    end
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

game = PlayGame.new
game.play_game
