require_relative '../connect_4.rb'
# testing file for the Odin project's connect four project using TDD. 7 wide 6 high
# author: Malcolm Bailey
describe ConnectFour do

  describe '#initialize' do
    context 'player presses enter to start game' do
      it 'Loads the empty board and prompts player 1 to move' do
        allow(game_start).to receive(:gets).and_return('\n')
        expect(game_start).to receive(:start_game).once
        subject(:game_start) { described_class.new }
      end
    end
  end

  describe '#player_move' do
    subject(:game_start) { described_class.new }
    context 'When user provides valid move' do
      it 'puts piece on bottom of an empty column' do
        game_start.place_piece(3)
        game_board = game_start.instance_variable_get(:@board)
        expect(game_board[2][0]).to eql(1)
      end

      it 'puts piece on top of a filled column spot' do
        2.times { game_start.place_piece(3) }
        game_board = game_start.instance_variable_get(:@board)
        expect(game_board[2][1]).to eql(2)
      end
    end

    context 'When user provides invalid input' do
      it 'warns player of invalid input, then asks for input again' do
        allow(game_start).to receive(:gets).and_return('a', ' ')
        expect(game_start).to receive(:puts).with('Error, invalid column choice!').twice
        game_start.player_input(1)
      end
    end

    context 'When user provides valid input on full column' do
      it 'warns player of full column and asks for a new input' do
        6.times { game_start.place_piece(1) }
        allow(game_start).to receive(:gets).and_return('2')
        expect(game_start).to receive(:puts).with('That column is full! Choose another.').once
        game_start.place_piece(1)
      end
    end
  end

  describe '#game_over?' do

    end_game_board = [[2, 2, 1, 2, 2, 2, 0],
                      [1, 2, 1, 2, 2, 1, 2],
                      [2, 2, 1, 1, 1, 2, 1],
                      [1, 1, 2, 1, 1, 2, 1],
                      [1, 1, 2, 2, 2, 1, 1],
                      [1, 1, 1, 2, 1, 1, 2],
                    ]

    tie_game_board = [[2, 2, 1, 2, 2, 2, 0],
                      [1, 2, 1, 2, 2, 2, 2],
                      [2, 2, 1, 1, 1, 2, 1],
                      [1, 1, 2, 1, 1, 2, 1],
                      [1, 1, 2, 2, 2, 1, 1],
                      [1, 1, 1, 2, 1, 1, 2],
                   ]                
    

    it 'returns true when player 1 wins' do
      subject(:game_end) { described_class.new(end_game_board) }
      game_end.player_move(7)
      expect{ game_end.game_over? }.to eql(true)
    end

    it 'returns true when player 2 wins' do
      subject(:game_end) { described_class.new(end_game_board, turn = 2) } 
      game_end.player_move(7)
      expect{ game_end.game_over? }.to eql(true)

    end

    it 'returns true when the board is full' do
      subject(:game_end) { described_class.new(tie_game_board, turn = 1) } 
      game_end.player_move(7)
      expect{ game_end.game_over? }.to eql(true)
    end

    it 'returns false when the board is empty' do
      subject(:game_end) { described_class.new } 
      expect{ game_end.game_over? }.to eql(false)
    end
  end

end
