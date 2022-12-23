require_relative '../connect_4.rb'
# testing file for the Odin project's connect four project using TDD. 7 wide 6 high
# author: Malcolm Bailey
describe ConnectFour do

  describe '#initialize' do
    context 'player presses any button to start game' do
      it 'receives player input and begins game' do
        subject { described_class.new }
        allow(subject).to receive(:gets).and_return('\n')
        expect(subject).to receive(:play_game).once
        subject.start_game
      end
    end
  end

  describe '#prompt_player_move' do
    context 'receives valid player input' do
      it 'returns the input' do
        subject { described_class.new }
        allow(subject).to receive(:gets).and_return('2')
        expect(subject.prompt_player_move).to eql('2')
      end
    end

    context 'receives invalid input twice, then valid input' do
      it 'returns the final input' do
        subject { described_class.new }
        allow(subject).to receive(:gets).and_return('a', '', '4')
        expect(subject.prompt_player_move).to eql('4')
      end
    end

    context 'attempts to place a piece on a full column' do
      subject(:game_start) { described_class.new }
      it 'warns player of full column and asks for a new input' do
        6.times { game_start.place_piece(1) }
        allow(game_start).to receive(:gets).and_return('2', '3')
        expect(game_start).to receive(:valid_move?).and_return(false, true)
        game_start.prompt_player_move
      end
    end
  end

  describe '#place_piece' do
    subject(:game_start) { described_class.new }
    context 'When user provides valid move' do
      it 'puts piece on bottom of an empty column' do
        game_start.place_piece(3)
        game_board = game_start.instance_variable_get(:@board)
        expect(game_board[5][2]).to eql(1)
      end

      it 'puts piece on top of a filled column spot' do
        game_start.turn = 2
        2.times { game_start.place_piece(3) }
        game_board = game_start.instance_variable_get(:@board)
        expect(game_board[4][2]).to eql(2)
      end
    end
  end

  describe '#game_over?' do
    end_game_board = [[2, 2, 1, 2, 2, 2, 0],
                      [1, 2, 1, 2, 2, 2, 1],
                      [2, 2, 1, 1, 1, 2, 1],
                      [1, 1, 2, 1, 2, 1, 1],
                      [1, 1, 2, 2, 2, 1, 2],
                      [1, 1, 1, 2, 1, 1, 2]]

    tie_game_board = [[2, 2, 1, 2, 2, 2, 0],
                      [1, 2, 1, 2, 2, 2, 2],
                      [2, 2, 1, 1, 1, 2, 1],
                      [1, 1, 2, 1, 1, 2, 1],
                      [1, 1, 2, 2, 2, 1, 1],
                      [1, 1, 1, 2, 1, 1, 2]]
    context 'when player 2 wins horizontally' do
      subject(:game_end) { described_class.new(end_game_board, 2) }
      it 'returns true' do
        game_end.place_piece(7)
        expect(game_end.game_over?).to eql(true)
      end
    end

    context ' when player 1 wins vertically' do
      subject(:game_end) { described_class.new(end_game_board, 1) }
      it 'returns true' do
        game_end.place_piece(7)
        expect(game_end.game_over?).to eql(true)
      end
    end

    context ' when player 1 wins diagonally' do
      xit 'returns true' do
      end
    end

    context 'when board is full without winners' do
      subject(:game_end) { described_class.new(tie_game_board, 1) }
      xit 'returns true' do
        game_end.place_piece(7)
        expect(game_end.game_over?).to eql(true)
      end
    end

    context 'when board is empty' do
      subject(:game_end) { described_class.new }
      xit 'returns false' do
        expect(game_end.game_over?).to eql(false)
      end
    end
  end
end
