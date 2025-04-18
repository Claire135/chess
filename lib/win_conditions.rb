class WinConditions
  attr_reader :in_check, :checking_piece

  def initialize(board)
    @checking_piece = nil
    @board = board
    @in_check_piece = nil
    @white_king = @board.white_pieces[0]
    @black_king = @board.black_pieces[0]
  end

  def checkmate?
    capture_checking_piece?
  end

  def stalemate?
  end

  def check?
    if check_white?
      puts 'White king is in check!'
      @in_check_piece = @white_king
      true
    elsif check_black?
      puts 'Black king is in check!'
      @in_check_piece = @black_king
      true
    else
      @in_check_piece = nil
      @checking_piece = nil
      false
    end
  end

  def king_move?
    @in
  end

  def block_path?
  end

  def capture_checking_piece?
    return false unless @checking_piece

    attackers = @checking_piece.color == 'black' ? @board.white_pieces : @board.black_pieces
    attackers.any? do |piece|
      piece.valid_move?(@board, piece.position, @checking_piece.position)
    end
  end

  private

  def check_black?
    @board.white_pieces[1..].any? do |piece|
      @checking_piece = piece if piece.valid_move?(@board, piece.position, @black_king.position)
    end
  end

  def check_white?
    @board.black_pieces[1..].any? do |piece|
      @checking_piece = piece if piece.valid_move?(@board, piece.position, @white_king.position)
    end
  end
end
