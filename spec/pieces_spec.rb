require_relative '../lib/pieces/pieces'

describe Pieces do
  subject(:piece) { described_class.new('white', [7, 0], '♖', 'TestPiece') }

  describe '#horizontal_move?' do
    context 'if a piece receives horizontal coordinates' do
      it 'returns true' do
        expect(piece.horizontal_move?([3, 0], [3, 7])).to eq(true)
      end
    end

    context 'if a piece receives a non-horizontal move' do
      it 'returns false' do
        expect(piece.horizontal_move?([3, 0], [4, 7])).to eq(false)
      end
    end
  end

  describe '#vertical_move?' do
    context 'if a piece receives vertical coordinates' do
      it 'returns true' do
        expect(piece.vertical_move?([2, 1], [7, 1])).to eq(true)
      end
    end

    context 'if a piece receives a non-vertical move' do
      it 'returns false' do
        expect(piece.vertical_move?([3, 0], [4, 7])).to eq(false)
      end
    end
  end

  describe '#diagonal_move?' do
    context 'if a piece receives diagonal coordinates' do
      it 'returns true' do
        expect(piece.diagonal_move?([6, 0], [4, 3]))
      end
    end

    context 'if a piece receives non-diagonal coordinates' do
      it 'returns false' do
        expect(piece.diagonal_move?([0, 0], [0, 5]))
      end
    end
  end
end
