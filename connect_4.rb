
class ConnectFour
  attr_accessor :board, :turn
  # 7 wide 6 high
  # (0, 0) is top left of board, (5, 6) is bottom right
  # constructor takes board and player turn as optional inputs
  def initialize(board = [[0, 0, 0, 0, 0, 0, 0],
                          [0, 0, 0, 0, 0, 0, 0],
                          [0, 0, 0, 0, 0, 0, 0],
                          [0, 0, 0, 0, 0, 0, 0],
                          [0, 0, 0, 0, 0, 0, 0],
                          [0, 0, 0, 0, 0, 0, 0]],
                turn = 1)
    @board = board
    @turn = turn
    @full_board = false
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
    puts "Player #{@turn}, type in the column you'd live to place a piece in! (between 1 and 7)"
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
    # we decrement to go from common numbering to ruby indexing
    move -= 1
    @board[0][move].zero? ? true : false
  end

  def place_piece(move)
    # decrement move by one to adjust from normal ways to refer
    # to column to the indexing system
    move -= 1
    @board.to_enum.with_index.reverse_each do |(row, index)|
      if row[move].zero?
        @board[index][move] = @turn
        break
      end
    end
  end

  def game_over?
    # check that there's 4 in a row in any direction
    # then that the board is full
    # UNFINISHED
    
    @board.each.with_index do |row, row_index|
      player_token_horizontal = 0
      player_token_vertical = 0
      consecutive_occurences_horizontal = 0
      consecutive_occurences_vertical = 0

      row.each.with_index do |slot, col_index|
        if row_index.zero?
          next_row_index = 1
          player_token_vertical = slot
          consecutive_occurences_vertical = 1
          # vertical check for each column (just from top down)
          until next_row_index > 5
            next_vertical_slot = @board[next_row_index][col_index]
            if next_vertical_slot == player_token_vertical
              consecutive_occurences_vertical += 1
            else
              player_token_vertical = next_vertical_slot
              consecutive_occurences_vertical = 1
            end
            return true if consecutive_occurences_vertical == 4

            next_row_index += 1
          end

        end

        # horizontal transversal
        if slot == player_token_horizontal
          consecutive_occurences_horizontal += 1
        else
          player_token_horizontal = slot
          consecutive_occurences_horizontal = 1
        end
        return true if consecutive_occurences_horizontal == 4

        # diagonal transversal
        # the first 4 across and 3 down can be possible wins down right
        # the last 4 across and first 3 downcan be possible wins down left
      end
    end
    false
  end
end