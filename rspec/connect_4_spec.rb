require_relative '../connect_4'
# testing file for the Odin project's connect four project using TDD.
# author: Malcolm Bailey
describe ConnectFour do
  describe '#start_game' do
    subject(:game_start) { described_class.new }
    context 'player presses enter' do
      it 'Loads the empty board and prompts player 1 to move' do
        allow(game_start).to receive(:gets).and_return('\n')
        expect(game_start).to receive(:start_game).once
      end
    end
  end

  describe '#player_move' do
    subject(:game_start) { described_class.new }
    context 'When user provides valid move' do
      it 'puts piece on bottom of an empty column' do
        game_start.player_input(3)
        game_board = game_start.instance_variable_get(:@board)
        expect(game_board[2][0]).to eql(1)
      end

      it 'puts piece on top of a filled column spot' do
        2.times { game_start.player_input(3) }
        game_board = game_start.instance_variable_get(:@board)
        expect(game_board[2][1]).to eql(2)
      end
    end

    context 'When user provides invalid input' do
      it 'warns player of invalid input, then asks for input again' do
        allow(game_start).to receive(:gets).and_return('a', ' ')
        expect(game_start).to receive(:puts).with('Error, invalid column choice!').twice
        game_start.player_input
      end
    end

    context 'When user provides valid input on full column' do
      it 'warns player of full column and asks for a new input' do
        5.times { game_start.player_input(1) }
        allow(game_start).to receive(:gets).and_return('2')
        expect(game_start).to receive(:puts).with('That column is full! Choose another.').once
        game_start.player_input
      end
    end
  end

  describe '#show_end_screen' do
    context 'When player 1 wins game' do
      it 'displays player 1 win screen' do
      end
    end

    context 'When player 2 wins game' do
      it 'displays player 2 win screen' do
      end
    end
  end
end
