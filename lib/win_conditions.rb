require_relative 'serializable/base_serializable'

class WinConditions
  include BaseSerializable
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

    start_row, start_col = @in_check_piece.position
    potential_path = [
      [start_row + 1, start_col], [start_row - 1, start_col],
      [start_row, start_col + 1], [start_row, start_col - 1],
      [start_row + 1, start_col + 1], [start_row + 1, start_col - 1],
      [start_row - 1, start_col + 1], [start_row - 1, start_col - 1]
    ]
    potential_path.any? { |square| @in_check_piece.valid_move?(@board, @in_check_piece.position, square) }
  end

  def block_path?
    return false unless @checking_piece && @in_check_piece

    path = @board.between(@checking_piece.position, @in_check_piece.position)
    return false if path.nil? || !@board.path_clear?(@checking_piece.position, @in_check_piece.position)

    @defenders.any? do |piece|
      path.any? { |square| piece.valid_move?(@board, piece.position, square) }
    end
  end

  def to_h
    {
      checking_piece: @checking_piece&.to_h,
      in_check_piece: @in_check_piece&.to_h,
      attackers: @attackers.map(&:to_h),
      defenders: @defenders.map(&:to_h)
    }
  end

  def self.from_h(hash, board)
    WinConditions.new(board).tap do |win|
      win.checking_piece = hash['checking_piece'] ? Pieces.from_h(hash['checking_piece']) : nil
      win.in_check_piece = hash['in_check_piece'] ? Pieces.from_h(hash['in_check_piece']) : nil
      win.defenders = hash['defenders'].map { |d| Pieces.from_h(d) }
      win.attackers = hash['attackers'].map { |a| Pieces.from_h(a) }
      win.white_king = board.white_pieces[0]
      win.black_king = board.black_pieces[0]
    end
  end

  # private

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
