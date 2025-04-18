require_relative '../lib/board'
require_relative '../lib/win_conditions'

require_relative '../lib/board'
require_relative '../lib/win_conditions'

describe WinConditions do
  let(:white_king) { double('King', color: 'white', position: [7, 4]) }
  let(:black_king) { double('King', color: 'black', position: [0, 4]) }

  let(:board) do
    instance_double(Board,
                    white_pieces: [white_king],
                    black_pieces: [black_king])
  end

  subject(:win) { described_class.new(board) }

  describe '#capture_checking_piece?' do
    context 'when there is a checking piece and it can be captured' do
      let(:checking_piece) { double('Piece', color: 'black', position: [4, 4]) }
      let(:attacking_piece) { double('White Piece', position: [5, 4]) }

      before do
        win.instance_variable_set(:@checking_piece, checking_piece)
        allow(board).to receive(:white_pieces).and_return([attacking_piece])
        allow(board).to receive(:black_pieces).and_return([])

        allow(attacking_piece).to receive(:valid_move?).with(board, [5, 4], [4, 4]).and_return(true)
      end

      it 'returns true' do
        expect(win.capture_checking_piece?).to eq(true)
      end
    end

    context 'when there is a checking piece and it cannot be captured' do
      let(:checking_piece) { double('Piece', color: 'black', position: [4, 4]) }
      let(:attacking_piece) { double('White Piece', position: [5, 4]) }

      before do
        win.instance_variable_set(:@checking_piece, checking_piece)
        allow(board).to receive(:white_pieces).and_return([attacking_piece])
        allow(board).to receive(:black_pieces).and_return([])

        allow(attacking_piece).to receive(:valid_move?).with(board, [5, 4], [4, 4]).and_return(false)
      end

      it 'returns false' do
        expect(win.capture_checking_piece?).to eq(false)
      end
    end

    context 'when there is no checking piece' do
      before do
        win.instance_variable_set(:@checking_piece, nil)
      end

      it 'returns false' do
        expect(win.capture_checking_piece?).to eq(false)
      end
    end
  end
end
