module BoardSerializable
  def to_h
    {
      white_pieces: @white_pieces.map(&:to_h),
      black_pieces: @black_pieces.map(&:to_h),
      board: @board.map { |row| row.map(&:to_h) } # Serialize the board as an array of arrays of piece data
    }
  end

  def self.from_h(hash)
    Board.new.tap do |board|
      board.white_pieces = hash['white_pieces'].map { |w| Pieces.from_h(hash['white_pieces']) }
      board.black_pieces = hash['black_pieces'].map { |b| Pieces.from_h(hash['black_pieces']) }

      board.board = Array.new(8) { Array.new(8) }
      (board.white_pieces + board.black_pieces).each do |piece|
        row, col = piece.position
        board.board[row][col] = piece
      end
    end
  end
end
