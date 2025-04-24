# frozen_string_literal: true

require_relative '../lib/pieces/pawn'
require_relative '../lib/pieces/pieces'
require_relative '../lib/board'

describe Pawn do
  let(:board) { Board.new }

  describe '#move_two_steps_forward?' do
    context 'for a white pawn' do
      subject(:white_pawn) { described_class.new('white', [6, 4], '♙', 'White Pawn') }

      it 'returns true when moving two spaces forward on first move' do
        expect(white_pawn.move_two_steps_forward?([6, 4], [4, 4])).to eq(true)
      end

      it 'returns false when moving two spaces backward' do
        expect(white_pawn.move_two_steps_forward?([5, 4], [7, 4])).to eq(false)
      end

      it 'returns false when not on first move' do
        white_pawn.instance_variable_set(:@move_count, 1)
        expect(white_pawn.move_two_steps_forward?([6, 4], [4, 4])).to eq(false)
      end

      it 'returns false when trying to move two spaces sideways' do
        expect(white_pawn.move_two_steps_forward?([6, 4], [4, 5])).to eq(false)
      end
    end

    context 'for a black pawn' do
      subject(:black_pawn) { described_class.new('black', [1, 3], '♟︎', 'Black Pawn') }

      it 'returns true when moving two spaces forward on first move' do
        expect(black_pawn.move_two_steps_forward?([1, 3], [3, 3])).to eq(true)
      end

      it 'returns false when moving two spaces backward' do
        expect(black_pawn.move_two_steps_forward?([2, 3], [0, 3])).to eq(false)
      end

      it 'returns false when not on first move' do
        black_pawn.instance_variable_set(:@move_count, 1)
        expect(black_pawn.move_two_steps_forward?([1, 3], [3, 3])).to eq(false)
      end

      it 'returns false when trying to move two spaces sideways' do
        expect(black_pawn.move_two_steps_forward?([1, 3], [3, 4])).to eq(false)
      end
    end
  end

  describe '#move_one_step_forward?' do
    context 'for a white pawn' do
      subject(:white_pawn) { described_class.new('white', [6, 4], '♙', 'White Pawn') }

      it 'returns true when moving one step forward' do
        expect(white_pawn.move_one_step_forward?([6, 4], [5, 4])).to eq(true)
      end

      it 'returns false when moving one step backward' do
        expect(white_pawn.move_one_step_forward?([5, 4], [6, 4])).to eq(false)
      end

      it 'returns false when moving sideways' do
        expect(white_pawn.move_one_step_forward?([6, 4], [6, 5])).to eq(false)
      end

      it 'returns false when moving diagonally' do
        expect(white_pawn.move_one_step_forward?([6, 4], [5, 5])).to eq(false)
      end
    end

    context 'for a black pawn' do
      subject(:black_pawn) { described_class.new('black', [1, 3], '♟︎', 'Black Pawn') }

      it 'returns true when moving one step forward' do
        expect(black_pawn.move_one_step_forward?([1, 3], [2, 3])).to eq(true)
      end

      it 'returns false when moving one step backward' do
        expect(black_pawn.move_one_step_forward?([2, 3], [1, 3])).to eq(false)
      end

      it 'returns false when moving sideways' do
        expect(black_pawn.move_one_step_forward?([1, 3], [1, 4])).to eq(false)
      end

      it 'returns false when moving diagonally' do
        expect(black_pawn.move_one_step_forward?([1, 3], [2, 4])).to eq(false)
      end
    end
  end

  describe '#move_one_step_diagonally?' do
    let(:board) { instance_double(Board) }

    context 'for a white pawn' do
      subject(:white_pawn) { described_class.new('white', [6, 4], '♙', 'White Pawn') }

      it 'returns true when moving diagonally to capture an enemy' do
        allow(board).to receive(:enemy_at?).with([5, 5], 'white').and_return(true)
        expect(white_pawn.move_one_step_diagonally?(board, [6, 4], [5, 5])).to eq(true)
      end

      it 'returns false when moving diagonally with no enemy' do
        allow(board).to receive(:enemy_at?).with([5, 5], 'white').and_return(false)
        expect(white_pawn.move_one_step_diagonally?(board, [6, 4], [5, 5])).to eq(false)
      end

      it 'returns false when moving vertically forward' do
        allow(board).to receive(:enemy_at?).and_return(false)
        expect(white_pawn.move_one_step_diagonally?(board, [6, 4], [5, 4])).to eq(false)
      end

      it 'returns false when moving sideways' do
        allow(board).to receive(:enemy_at?).and_return(false)
        expect(white_pawn.move_one_step_diagonally?(board, [6, 4], [6, 5])).to eq(false)
      end
    end

    context 'for a black pawn' do
      subject(:black_pawn) { described_class.new('black', [1, 3], '♟︎', 'Black Pawn') }

      it 'returns true when moving diagonally to capture an enemy' do
        allow(board).to receive(:enemy_at?).with([2, 2], 'black').and_return(true)
        expect(black_pawn.move_one_step_diagonally?(board, [1, 3], [2, 2])).to eq(true)
      end

      it 'returns false when moving diagonally with no enemy' do
        allow(board).to receive(:enemy_at?).with([2, 2], 'black').and_return(false)
        expect(black_pawn.move_one_step_diagonally?(board, [1, 3], [2, 2])).to eq(false)
      end

      it 'returns false when moving vertically forward' do
        allow(board).to receive(:enemy_at?).and_return(false)
        expect(black_pawn.move_one_step_diagonally?(board, [1, 3], [2, 3])).to eq(false)
      end

      it 'returns false when moving sideways' do
        allow(board).to receive(:enemy_at?).and_return(false)
        expect(black_pawn.move_one_step_diagonally?(board, [1, 3], [1, 4])).to eq(false)
      end
    end
  end
end
