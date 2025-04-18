module WinConditions
  def checkmate?
  end

  def stalemate?
  end

  def check?
    white_king = @white_pieces[0]
    black_king = @black_pieces[0]
    if check_white?
      puts 'White king is in check!'
      white_king.in_check = true
    elsif check_black?
      puts 'Black king is in check!'
      black_king.in_check = true
    end
    false
  end

  private

  def check_black?
    black_king = @black_pieces[0]
    black_king.position

    @white_pieces[1..].any? do |piece|
      piece.valid_move?(self, piece.position, black_king.position)
    end
  end

  def check_white?
    white_king = @white_pieces[0]
    white_king.position

    @black_pieces[1..].any? do |piece|
      piece.valid_move?(self, piece.position, white_king.position)
    end
  end
end
