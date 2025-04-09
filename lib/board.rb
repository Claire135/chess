require_relative 'pieces/pieces'
require_relative 'pieces/knight'
require_relative 'pieces/bishop'
require_relative 'pieces/king'
require_relative 'pieces/pawn'
require_relative 'pieces/castle'
require_relative 'pieces/queen'
require_relative 'movable'
require_relative 'player_input'

class Board
  include Movable
  include PlayerInput

  def initialize
    @board = Array.new(8) { Array.new(8) }
    @current_piece = nil
    @white_pieces = [
      Castle.new('white', [7, 0], '♖', 'Castle 1'),
      Castle.new('white', [7, 7], '♖', 'Castle 2'),
      Knight.new('white', [7, 1], '♘', 'Knight 1'),
      Knight.new('white', [7, 6], '♘', 'Knight 2'),
      Bishop.new('white', [7, 2], '♗', 'Bishop 1'),
      Bishop.new('white', [7, 5], '♗', 'Bishop 2'),
      Queen.new('white', [7, 3], '♕', 'Queen'),
      King.new('white', [7, 4], '♔', 'King')
    ]

    (0..7).each do |col|
      @white_pieces << Pawn.new('white', [6, col], '♙', 'Pawn(1..8)')
    end

    @black_pieces = [
      Castle.new('black', [0, 0], '♜', 'Castle 1'),
      Knight.new('black', [0, 1], '♞', 'Knight 1'),
      Bishop.new('black', [0, 2], '♝', 'Bishop 1'),
      Queen.new('black', [0, 3], '♛', 'Queen'),
      King.new('black', [0, 4], '♚', 'King'),
      Knight.new('black', [0, 6], '♞', 'Knight 2'),
      Bishop.new('black', [0, 5], '♝', 'Bishop 2'),
      Castle.new('black', [0, 7], '♜', 'Castle 2')
    ]

    (0..7).each do |col|
      @black_pieces << Pawn.new('black', [1, col], '♟', 'Pawn(1..8)')
    end
  end

  def display_board
    place_pieces
    generate_board
  end

  def delete_captured_piece(captured_piece)
    if @white_pieces.include?(captured_piece)
      @white_pieces.delete(captured_piece)
    else
      @black_pieces.delete(captured_piece)

    end
  end

  def move_piece
    start_coordinate = request_and_process_start_coordinate
    @current_piece = find_matching_piece(start_coordinate)
    end_coordinate = request_and_process_end_coordinate
    p validate_end_coordinate(end_coordinate, @current_piece)
  end

  private

  def place_pieces
    (@white_pieces + @black_pieces).each do |piece|
      row, col = piece.position
      @board[row][col] = piece
    end
  end

  def generate_board
    puts '  a b c d e f g h'
    @board.each_with_index do |row, i|
      print "#{8 - i} "
      row.each do |square|
        print square ? square.symbol + ' ' : '. '
      end
      puts "#{8 - i}"
    end
    puts '  a b c d e f g h'
  end
end

board = Board.new
board.display_board
board.move_piece
