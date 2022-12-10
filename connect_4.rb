
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

    puts 'Welcome to connect four! Press enter to start'
    until gets == '\n'
    start_game
  end

  def start_game
    until game_over?
      display_board
      move = get_player_move
      place_piece(move)
      @turn == 1 ? @turn = 2 : @turn = 1
    end
    display_game_over
  end

  def get_player_move
    puts "Player #{@turn}, type in the column you'd live to place a piece in!"
    move = gets.chomp
    until valid_move?(move)
      puts 'Invalid move, enter the number of a column that has a free space (from 1 to 7).'
      move = gets.chomp
    end
    move
  end

  def valid_move?(move)
    move.length == 1 && move.scan('[1-7]').empty? && column_free?(move.to_i)
  end

  def column_free?(move)
    #move is an integer representing a column of the board between 1 and 7.
    @board.each do |row|
      return true if row[move] == 0
    end
    return false
  end

  def place_piece(move)
    @board.to_enum.with_index.reverse_each do |(row, index)|
      @board[index][move] = @turn if row[move] == 0
    end
  end
end