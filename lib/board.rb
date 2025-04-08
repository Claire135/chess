require_relative 'pieces/pieces'
require_relative 'pieces/knight'
require_relative 'pieces/bishop'
require_relative 'pieces/king'
require_relative 'pieces/pawn'
require_relative 'pieces/castle'
require_relative 'pieces/queen'

class Board
  def initialize
    @board = Array.new(8) { Array.new(8) }
    @white_pieces = [
      Knight.new('white', [7, 1], '♘'),
      Knight.new('white', [7, 6], '♘')
    ]

    @black_pieces = [
      Knight.new('black', [0, 1], '♞'),
      Knight.new('black', [0, 6], '♞')
    ]
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
