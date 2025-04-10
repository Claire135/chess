require_relative 'pieces/pieces'
require_relative 'pieces/knight'
require_relative 'pieces/bishop'
require_relative 'pieces/king'
require_relative 'pieces/pawn'
require_relative 'pieces/castle'
require_relative 'pieces/queen'

class Board
  attr_reader :white_pieces, :black_pieces
  attr_accessor :board

  def initialize
    @board = Array.new(8) { Array.new(8) }
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

  def [](row, col)
    @board[row][col]
  end

  def []=(row, col, value)
    @board[row][col] = value
  end

  def captured_piece_at(coordinate)
    row, col = coordinate
    @board[row][col]
  end

  def delete_captured_piece(piece)
    if piece.color == 'white'
      @white_pieces.delete(piece)
    else
      @black_pieces.delete(piece)
    end
    @board[piece.position[0]][piece.position[1]] = nil
  end

  def empty_at?(row, col)
    @board[row][col].nil?
  end

  def enemy_piece_at?(row, col, color)
    piece = @board[row][col]
    piece && piece.color != color
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
      print "#{i + 1} "
      row.each do |square|
        print square ? square.symbol + ' ' : '. '
      end
      puts "#{i + 1}"
    end
    puts '  a b c d e f g h'
  end
end
