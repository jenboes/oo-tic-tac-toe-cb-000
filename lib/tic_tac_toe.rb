# Tic Tac Toe game main object
class TicTacToe

  def board
    @board
  end

  def player
    @player
  end

  def next_move
    @next_move
  end

  def initialize
    @board = [" "," "," "," "," "," "," "," "," "]
  end

  def display_board
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
  end

  def input_to_index(nextmove)
    nextmovei = nextmove.to_i - 1
  end

  def move(index,player="X")
    @board[index] = player;
  end

  def position_taken?(index_number)
    # do some error checking
    #if index_number>9 || index_number<0
    #  return true
    #else
    if @board[index_number] == nil
      return false
    elsif @board[index_number]=="" || @board[index_number]==" "
        return false
    else
      return true
    end
  end

  def valid_move?(index_number)
    if !index_number.between?(0,8)
      return false
    elsif position_taken?(index_number)
      return false
    else
      return true
    end
  end

  def current_player
    # player X starts
    turn_count % 2 == 0 ? "X" : "O"
  end

  # def turn_count
  #   @board.count { |x| x != "" || x != " " || x != nil}
  # end

  def turn_count
    count = 0
    @board.each do |space|
      if space!=" "
        count += 1
      end
    end
    return count
  end

  def turn
    # Invite move
    puts "Please enter 1-9:"
    nmove = gets.strip
    # Convert user input to index
    nmovei = input_to_index(nmove)
    while !valid_move?(nmovei)
      puts "Oops. Try again."
      puts "Please enter 1-9:"
      nmove = gets.strip
      # Convert user input to index
      nmovei = input_to_index(nmove)
    end
    move(nmovei,current_player)
    display_board
  end

  def position_taken?(index)
    !(@board[index].nil? || @board[index] == " ")
  end

  # Won - return the board positions if someone has won
  def won?
    # cycle through WIN_COMBINATIONS
    WIN_COMBINATIONS.detect { |winning_combo|
      # print win_index
      # print '\n'
      position_taken?(winning_combo[0]) &&
        position_taken?(winning_combo[1]) &&
        position_taken?(winning_combo[2]) &&
        @board[winning_combo[0]] == @board[winning_combo[1]] &&
        @board[winning_combo[1]] == @board[winning_combo[2]]
    }
  end

  # Full? Return true if board is full
  def full?
    @board.find { |square| square.nil? || square == " " } ? false : true
  end

  # Draw? Return true if board is full and is a draw
  #       Return false is board not full or there is a winner
  def draw?
    board_complete = full?
    board_won = won?
    board_complete && !board_won ? true : false
  end

  # Over? Return if the board has been won, is a draw, or is full.
  def over?
    full? || won? || draw?
  end

  # Winner accept a board and return the token, "X" or "O" that has won the game given a winning board.
  def winner
    # Return the square entry from the winning configuration
    won? ? @board[won?[0]] : nil
  end

  def play

    while !over?
      turn
    end
    if won?
      puts ("Congratulations #{winner}!")
    elsif draw?
      puts ("Cat's Game!")
    end
  end


  WIN_COMBINATIONS = [
    [0,1,2], # Top row
    [3,4,5], # Middle row
    [6,7,8], # Bottom row
    [0,3,6], # First column
    [1,4,7], # Second column
    [2,5,8], # Third column
    [0,4,8], # Diagonal 1
    [2,4,6]  # Diagonal 2
    # ETC, an array for each win combination
  ]

end
