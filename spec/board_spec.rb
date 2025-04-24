# frozen_string_literal: true

require_relative '../lib/board'
require_relative '../lib/pieces/king'

describe Board do
  let(:board) { Board.new }
  describe '#initialize' do
    context 'when board is initialized' do
      it 'creates 1 white king' do
        expect(board.white_pieces.count { |p| p.is_a?(King) }).to eq(1)
      end

      it 'creates 8 black pawns' do
        expect(board.black_pieces.count { |p| p.is_a?(Pawn) }).to eq(8)
      end
    end
  end

  # skipped as it is now a private method

  describe '#between' do
    subject(:board) { described_class.new }

    context 'when moving vertically' do
      xit 'returns coordinates of squares travelled minus the first and the last' do
        expect(board.between([2, 1], [7, 1])).to eq([[3, 1], [4, 1], [5, 1], [6, 1]])
      end
    end

    context 'when moving horizontally' do
      xit 'returns coordinates of squares between two columns' do
        expect(board.between([4, 2], [4, 6])).to eq([[4, 3], [4, 4], [4, 5]])
      end
    end

    context 'when moving diagonally' do
      xit 'returns coordinates of squares between two diagonals' do
        expect(board.between([2, 2], [5, 5])).to eq([[3, 3], [4, 4]])
      end
    end
  end

  describe '#path_clear?' do
    subject(:board) { described_class.new }

    before do
      board.instance_variable_set(:@board, Array.new(8) { Array.new(8, nil) })
    end

    context 'when the path is clear vertically' do
      it 'returns true' do
        expect(board.path_clear?([3, 1], [3, 5])).to eq(true)
      end
    end

    context 'when a piece is in the path' do
      it 'returns false' do
        piece = double('Piece', color: 'black')
        board.board[0][3] = piece # place a piece at c1 (index [0,3]) to block a1-f1
        expect(board.path_clear?([0, 0], [0, 5])).to eq(false)
      end
    end
  end
end
