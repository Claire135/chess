# frozen_string_literal: true

# Tests using actual Board Class

require_relative '../lib/pieces/pieces'
require_relative '../lib/pieces/castle'
require_relative '../lib/board'

describe Castle do
  subject(:castle) { described_class.new('black', [0, 0], '♖', 'Castle 1') }
  let(:board) { Board.new }

  describe '#valid_move?' do
    context 'when path is vertical, path is clear and end-coordinate is empty' do
      it 'returns true' do
        expect(castle.valid_move?(board, [3, 0], [3, 7])).to eq(true)
      end
    end

    context 'when path is horizontal, path is clear and there is an enemy on end square' do
      before do
        board.instance_variable_set(:@board, Array.new(8) { Array.new(8, nil) })
        enemy_piece = double('Piece', color: 'white')
        board.board[0][3] = enemy_piece
      end

      it 'returns true' do
        expect(castle.valid_move?(board, [0, 0], [0, 3])).to eq(true)
      end
    end

    context 'when path is vertical and path is not clear' do
      before do
        board.instance_variable_set(:@board, Array.new(8) { Array.new(8, nil) })
        blocking_piece = double('Piece', color: 'white')
        board.board[0][3] = blocking_piece
      end

      it 'returns false' do
        expect(castle.valid_move?(board, [0, 0], [0, 6])).to eq(false)
      end
    end

    context 'when path is horizontal, path is clear and there is a friendly piece on the end square' do
      before do
        board.instance_variable_set(:@board, Array.new(8) { Array.new(8, nil) })
        friendly_piece = double('Piece', color: 'black')
        board.board[0][6] = friendly_piece
      end

      it 'returns false' do
        expect(castle.valid_move?(board, [0, 0], [0, 6])).to eq(false)
      end
    end
  end
end
