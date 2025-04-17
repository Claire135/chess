# frozen_string_literal: true

require_relative 'move_context'
require_relative 'player'
require_relative 'board'
require_relative 'game_logic'

class PlayGame
  include GameLogic

  def initialize
    @chess_board = Board.new
    @white_player = Player.new('White Player', 'white')
    @black_player = Player.new('Black Player', 'black')
    @current_player = @white_player
    @move = MoveContext.new(@chess_board)
  end

  def play_game
    @chess_board.display_board
    loop do
      puts "#{@current_player.name}'s turn:"
      move_piece
      @chess_board.display_board
      switch_players
    end
  end

  private

  def move_piece
    @move.set_start_coordinate
    @move.set_current_piece
    @move.set_end_coordinate
    if @move.current_piece.valid_move?(@chess_board, @move.start_coordinate, @move.end_coordinate) &&
       @current_player.player_piece_match?(@move.current_piece)
      capture_piece
      @move.handle_movement
    else
      puts 'Invalid move, pick another!' # THIS NEEDS AN ERROR LOOP!!!!
    end
  end

  def capture_piece
    @move.handle_capture
    handle_capture_scores(@white_player)
    handle_capture_scores(@black_player)
    puts "White Player's Score: #{@white_player.score}"
    puts "Black Player's Score: #{@black_player.score}"
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
