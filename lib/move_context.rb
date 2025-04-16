require_relative 'board'
require_relative 'pieces/pieces'
require_relative 'player_input'

class MoveContext
  include PlayerInput
  attr_accessor :start_coordinate, :end_coordinate, :board, :current_piece, :last_move

  def initialize(board)
    @start_coordinate = nil
    @end_coordinate = nil
    @board = board
    @current_piece = nil
    @last_move = nil
  end

  def place_piece
    @start_coordinate = request_and_process_start_coordinate
    @current_piece = find_matching_piece
    @end_coordinate = request_and_process_end_coordinate
    if @current_piece.valid_move?(@board, @start_coordinate, @end_coordinate)
      handle_capture
      move_piece_to_end_coordinate
      update_piece_position
      update_last_move
    else
      puts 'Invalid move, pick another!'
    end
  end

  def set_coordinates
  end

  def update_last_move
    @last_move = {
      piece: @current_piece,
      start: @start_coordinates,
      end: @end_coordinates
    }
  end

  private

  def handle_capture
    captured_piece = @board.captured_piece_at(@end_coordinate) # Capture the piece at the destination

    return unless captured_piece # No piece to capture

    @board.delete_captured_piece(captured_piece)
  end

  def move_piece_to_end_coordinate
    end_row, end_col = @end_coordinate
    start_row, start_col = @start_coordinate
    @board[end_row, end_col] = @current_piece
    @board[start_row, start_col] = nil
  end

  def update_piece_position
    @current_piece.position = @end_coordinate
    @current_piece.count_moves
  end

  def validate_end_coordinate
    row, col = @end_coordinate
    @current_piece.valid_move?(row, col, @board)
  end

  def find_matching_piece
    all_pieces.find { |piece| piece.position == @start_coordinate }
  end

  def all_pieces
    @board.white_pieces + @board.black_pieces
  end
end
