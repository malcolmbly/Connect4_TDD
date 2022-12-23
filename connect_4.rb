
class ConnectFour
  attr_reader :board, :turn
  # 7 wide 6 high
  # constructor takes board and player turn as optional inputs
  def initialize(board = [[0, 0, 0, 0, 0, 0, 0],
                          [0, 0, 0, 0, 0, 0, 0],
                          [0, 0, 0, 0, 0, 0, 0],
                          [0, 0, 0, 0, 0, 0, 0],
                          [0, 0, 0, 0, 0, 0, 0],
                          [0, 0, 0, 0, 0, 0, 0],
                          turn = 1])
    @board = board
    @turn = turn
  end

  def start_game
    puts 'Welcome to connect four! Press any button to start'
    nil until gets
    play_game
  end

  def play_game
    until game_over?
      display_board
      move = prompt_player_move
      place_piece(move.to_i)
      @turn = @turn == 1 ? 2 : 1
    end
    display_game_over
  end

  def prompt_player_move
    puts "Player #{@turn}, type in the column you'd live to place a piece in!"
    move = gets.chomp
    until valid_move?(move)
      puts 'Invalid move, enter the number of a column that has a free space (from 1 to 7).'
      move = gets.chomp
    end
    move
  end

  def valid_move?(move)
    move.length == 1 && !move.scan(/[1-7]/).empty? && column_free?(move.to_i)
  end

  def column_free?(move)
    # move is an integer representing a column of the board between 1 and 7.
    @board.each do |row|
      return true if row[move].zero?
    end
    false
  end

  def place_piece(move)
    @board.to_enum.with_index.reverse_each do |(row, index)|
      if row[move].zero?
        @board[index][move] = @turn
        break
      end
    end
  end
end