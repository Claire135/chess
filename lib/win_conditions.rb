require_relative 'move_context'

class WinConditions
  attr_reader :in_check_piece, :checking_piece

  def initialize(board)
    @checking_piece = nil
    @board = board
    @in_check_piece = nil
    @white_king = @board.white_pieces[0]
    @black_king = @board.black_pieces[0]
    @attackers = []
    @defenders = []
  end

  def checkmate?
    return false unless @in_check_piece && @checking_piece

    define_roles

    cap = capture_checking_piece?
    blk = block_path?
    esc = king_escape?

    puts "capture_checking_piece?: #{cap}"
    puts "block_path?: #{blk}"
    puts "king_escape?: #{esc}"

    !cap && !blk && !esc
  end

  def stalemate?
  end

  def check?
    if check_white?
      @in_check_piece = @white_king
      true
    elsif check_black?
      @in_check_piece = @black_king
      true
    else
      @in_check_piece = nil
      @checking_piece = nil
      false
    end
  end

  def king_escape?
    return false unless @in_check_piece

    king = @in_check_piece
    start_row, start_col = king.position

    # Define potential escape squares for the king
    potential_escapes = [
      [start_row + 1, start_col], [start_row - 1, start_col],
      [start_row, start_col + 1], [start_row, start_col - 1],
      [start_row + 1, start_col + 1], [start_row + 1, start_col - 1],
      [start_row - 1, start_col + 1], [start_row - 1, start_col - 1]
    ]

    end_coordinates = potential_escapes.select { |coord| @board.empty_at?(coord) }

    end_coordinates.any? do |escape|
      @attackers.none? do |piece|
        piece.valid_move?(@board, piece.position, escape)
      end
    end
  end

  def block_path?
    return false if @checking_piece.nil? || @in_check_piece.nil?
    return false if @checking_piece.is_a?(Knight)

    potential_block = @board.between(@checking_piece.position, @in_check_piece.position)
    end_coordinates = potential_block.select { |coord| @board.empty_at?(coord) }

    end_coordinates.any? do |block|
      @defenders.any? do |piece|
        piece.valid_move?(@board, piece.position, block)
      end
    end
  end

  private

  def define_roles
    return unless @checking_piece

    case @checking_piece.color
    when 'black'
      @attackers = @board.white_pieces
      @defenders = @board.black_pieces
    when 'white'
      @attackers = @board.black_pieces
      @defenders = @board.white_pieces
    end
  end

  def capture_checking_piece?
    return false unless @checking_piece

    @attackers.any? do |piece|
      piece.valid_move?(@board, piece.position, @checking_piece.position)
    end
  end

  def check_black?
    @board.white_pieces[1..].any? do |piece|
      if piece.valid_move?(@board, piece.position, @black_king.position)
        @checking_piece = piece
        true
      else
        false
      end
    end
  end

  def check_white?
    @board.black_pieces[1..].any? do |piece|
      if piece.valid_move?(@board, piece.position, @white_king.position)
        @checking_piece = piece
        true
      else
        false
      end
    end
  end
end
