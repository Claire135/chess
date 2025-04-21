require_relative 'board_serializable'
require_relative 'player_serializable'
require_relative 'win_conditions_serializable'

module PlayGameSerializable
  def to_h
    {
      current_player: @current_player.to_h,
      chess_board: @chess_board.to_h,
      win: @win.to_h
    }
  end

  def self.from_h(hash)
    PlayGame.new.tap do |game|
      # Deserialize the current player using Player's from_h method
      game.instance_variable_set(:@current_player, Player.from_h(hash['current_player']))

      # Deserialize the board using Board's from_h method
      game.instance_variable_set(:@chess_board, Board.from_h(hash['chess_board']))

      # Deserialize the win conditions, passing in the deserialized board
      game.instance_variable_set(:@win, WinConditions.from_h(hash['win'], game.chess_board))

      # Optionally recreate @move (if needed, since it's not serialized):
      game.instance_variable_set(:@move, MoveContext.new(game.chess_board))
    end
  end
end
