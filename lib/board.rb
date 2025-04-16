require_relative 'pieces/pieces'
require_relative 'pieces/knight'
require_relative 'pieces/bishop'
require_relative 'pieces/king'
require_relative 'pieces/pawn'
require_relative 'pieces/castle'
require_relative 'pieces/queen'

# captured_piece_at - identifies captured piece
# delete_captured_piece - deletes captured piece
# [] - facilitate addition of coordinates from MoveContext
# empty_at? - checks if a square is empty
# enemy_piece_at? = checks if a pieces is of a different color

class Board
  attr_reader :white_pieces, :black_pieces
  attr_accessor :board

  def initialize
    @white_pieces = Board::WHITE_PIECE_ARRAY.dup

    (0..7).each do |col|
      @white_pieces << Pawn.new('white', [6, col], '♙', "Pawn #{col + 1}")
    end

    @black_pieces = Board::BLACK_PIECE_ARRAY.dup
    (0..7).each do |col|
      @black_pieces << Pawn.new('black', [1, col], '♟', "Pawn #{col + 1}")
    end

    @board = set_up_board
  end

  def set_up_board
    board = Array.new(8) { Array.new(8) }
    (@white_pieces + @black_pieces).each do |piece|
      row, col = piece.position
      board[row][col] = piece
    end
    board
  end

  def display_board
    generate_board
  end

  # Custom getter for accessing a square on the board
  def [](row, col)
    @board[row][col]
  end

  # Custom setter for placing a piece on the board
  def []=(row, col, piece)
    @board[row][col] = piece
  end

  # used in move_context: #handle_capture
  def captured_piece_at(coordinate)
    row, col = coordinate
    @board[row][col]
  end

  def empty_at?(end_coordinates)
    row, col = end_coordinates
    @board[row][col].nil?
  end

  # used in move_context: #handle_capture
  def delete_captured_piece(piece)
    if piece.color == 'white'
      @white_pieces.delete(piece)
    else
      @black_pieces.delete(piece)
    end
    @board[piece.position[0]][piece.position[1]] = nil
  end

  def enemy_at?(end_coordinates, color)
    row, col = end_coordinates
    piece = @board[row][col]
    piece && piece.color != color
  end

  def path_clear?(start_coordinates, end_coordinates)
    between(start_coordinates, end_coordinates).all? do |row, col|
      @board[row][col].nil?
    end
  end

  private

  def between(start_coordinates, end_coordinates)
    row1, col1 = start_coordinates
    row2, col2 = end_coordinates

    coordinates = []

    row_step = (row2 - row1) <=> 0
    col_step = (col2 - col1) <=> 0

    current_row = row1 + row_step
    current_col = col1 + col_step

    while [current_row, current_col] != [row2, col2]
      coordinates << [current_row, current_col]
      current_row += row_step
      current_col += col_step
    end

    coordinates
  end

  def generate_board
    puts '  a b c d e f g h'
    @board.each_with_index do |row, i|
      print "#{8 - i} "
      row.each do |square|
        print square ? square.symbol + ' ' : '. '
      end
      puts "#{8 - i} "
    end
    puts '  a b c d e f g h'
  end

  WHITE_PIECE_ARRAY = [
    Castle.new('white', [7, 0], '♖', 'Castle 1'),
    Castle.new('white', [7, 7], '♖', 'Castle 2'),
    Knight.new('white', [7, 1], '♘', 'Knight 1'),
    Knight.new('white', [7, 6], '♘', 'Knight 2'),
    Bishop.new('white', [7, 2], '♗', 'Bishop 1'),
    Bishop.new('white', [7, 5], '♗', 'Bishop 2'),
    Queen.new('white', [7, 3], '♕', 'Queen'),
    King.new('white', [7, 4], '♔', 'King')
  ]

  BLACK_PIECE_ARRAY = [
    Castle.new('black', [0, 0], '♜', 'Castle 1'),
    Knight.new('black', [0, 1], '♞', 'Knight 1'),
    Bishop.new('black', [0, 2], '♝', 'Bishop 1'),
    Queen.new('black', [0, 3], '♛', 'Queen'),
    King.new('black', [0, 4], '♚', 'King'),
    Knight.new('black', [0, 6], '♞', 'Knight 2'),
    Bishop.new('black', [0, 5], '♝', 'Bishop 2'),
    Castle.new('black', [0, 7], '♜', 'Castle 2')
  ]
end
