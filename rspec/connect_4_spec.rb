require_relative '../connect_4'
# testing file for the Odin project's connect four project using TDD.
# author: Malcolm Bailey
describe ConnectFour do
  describe '#start_game' do
    it 'Loads the empty board and prompts player 1 to move' do
    end
  end
  describe '#player_input' do
    context 'When user provides valid input' do
      it 'accepts player input and makes move' do
      end
    end

    context 'When user provides invalid input' do
      it 'warns player of invalid input, then asks for input again' do
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
