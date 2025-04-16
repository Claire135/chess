# Tests using actual Board Class

require_relative '../lib/pieces/pieces'
require_relative '../lib/pieces/castle'
require_relative '../lib/board'

describe Knight do
  subject(:knight) { described_class.new('black', [0, 1], '♞', 'Knight 1') }

  describe '#l-shape?' do
    context 'if a knight receives l-shaped coordinates' do
      it 'returns true' do
        expect(knight.l_shape_move?([0, 1], [2, 0])).to eq(true)
      end
    end

    context 'if a knight receives non l-shaped coordinates' do
      it 'returns false' do
        expect(knight.l_shape_move?([2, 6], [2, 7])).to eq(false)
      end
    end
  end

  describe '#valid_move?' do
    let(:board) { Board.new }
    context 'when path is l-shaped and end-coordinate is empty' do
      it 'returns true' do
        expect(knight.valid_move?(board, [2, 7], [4, 6])).to eq(true)
      end
    end

    context 'when path is l-shaped and there is an enemy on end square' do
      before do
        board.instance_variable_set(:@board, Array.new(8) { Array.new(8, nil) })
        enemy_piece = double('Piece', color: 'white')
        board.board[2][3] = enemy_piece
      end

      it 'returns true' do
        expect(knight.valid_move?(board, [3, 1], [2, 3])).to eq(true)
      end
    end

    context 'when path is l-shaped and there is a friendly piece on the end square' do
      before do
        board.instance_variable_set(:@board, Array.new(8) { Array.new(8, nil) })
        friendly_piece = double('Piece', color: 'black')
        board.board[5][6] = friendly_piece
      end

      it 'returns false' do
        expect(knight.valid_move?(board, [7, 7], [5, 6])).to eq(false)
      end
    end
  end
end
