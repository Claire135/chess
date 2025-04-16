require_relative 'move_context'
require_relative 'player'
require_relative 'board'

class PlayGame
  def initialize
    @chess_board = Board.new
    @white_player = Player.new('White Player')
    @black_player = Player.new('Black Player')
    @current_player = @white_player
    @move = MoveContext.new(@chess_board)
  end

  def play_game
    @chess_board.display_board
    loop do
      puts "#{@current_player.name}'s turn:"
      @move.place_piece
      @chess_board.display_board
      switch_players
    end
  end

  def switch_players
    @current_player = @current_player == @white_player ? @black_player : @white_player
  end
end

game = PlayGame.new
game.play_game
