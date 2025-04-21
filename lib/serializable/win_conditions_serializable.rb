module WinConditionsSerializable
  def to_h
    {
      checking_piece: @checking_piece ? @checking_piece.to_h : nil,
      in_check_piece: @in_check_piece ? @in_check_piece.to_h : nil,
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
end
