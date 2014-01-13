class Game
  SPACE = " "
  attr_reader :turn
  
  def initialize(user_object)
    @user = user_object
  end

  def reset(board_object)
    @board = board_object
    @turn_counter = 0   
    @turn = :human 
  end

  def play_game
    @user.print_out("Welcome to tic-tac-toe! The board is numbered as follows.")
    @user.print_out(@board.print_example_board)
    @user.print_out(@board.print_board)
    # who_goes_first?
    while @turn_counter < 10
      if @turn == :human
        @board.update_board(player_turn, "X")
      else 
        @board.update_board(computer_turn, "O")
      end
      @user.print_out(@board.print_board)
      change_turn
      game_check
    end
  end
  
  # def who_goes_first?
  #   input = ""
  #   until input == "first" || input == "second"
  #     @user.print_out("Would you like to go first or second? Please enter 'first' or 'second'.")
  #     input = @user.get_input
  #     if input == "first"
  #       user_first
  #     elsif input == "second"
  #       user_second
  #     end
  #   end
  # end

  # def user_first
  #   @turn = :human
  # end

  # def user_second
  #   @turn = :computer
  # end
  
  def player_turn
    @user.print_out("Where would you like to place your X?")
    position = @user.get_input.to_i
    until valid_move?(position)
      @user.print_out("Sorry, that is not a valid move, please try again.")
      position = @user.get_input.to_i
    end
    position
  end

  def computer_turn
    @user.print_out("The computer is playing...")
    sleep(0.5)
    if @board.board[5] == SPACE
      return 5
    else
      find_computer_move
    end
  end

  def change_turn
    @turn_counter +=1
    if @turn == :human
      @turn = :computer
    else
      @turn = :human
    end
  end

  def find_computer_move
    #I had inteded to break this out into 3 methods, however I was not sure how best to accomplish
    #this, since each method would need to return the position for the computer to win or block.
    #This would kick it back into the find_computer_move method, which would also require a return.
    #I am not sure if that would be easier to understand or not.
    @board.possible_wins.each do |line|
      if times_in_line(line, "O") == 2
        return empty_in_line(line) if empty_in_line(line)
      end
    end
    @board.possible_wins.each do |line|
      if times_in_line(line, "X") == 2
        return empty_in_line(line) if empty_in_line(line)
      end
    end
    @board.possible_wins.each do |line|
      if times_in_line(line, "O") == 1
        return empty_in_line(line) if empty_in_line(line)
      end
    end
    @board.board.each do |key, value| 
      if value == SPACE 
        return key
      end
    end
  end

  def times_in_line(poss_winning_line, player_mark)
    times = 0
    poss_winning_line.each do |index|
      times += 1 if @board.board[index] == player_mark
      unless @board.board[index] == player_mark || @board.board[index] == SPACE
        return 0
      end
    end
    times  
  end

  def empty_in_line(poss_winning_line)
    poss_winning_line.each do |index|
      if @board.board[index] == SPACE
        return index
      end
    end
  end

  def valid_move?(index)
    @board.board[index] == SPACE
  end

  def game_check
    @board.possible_wins.each do |line|
      if times_in_line(line, "X") == 3
        @user.print_out("Oops, it looks like you win!  That wasn't supposed to happen :|")
        game_over
      elsif times_in_line(line, "O") == 3
        @user.print_out("The computer wins!")
        game_over
      elsif @turn_counter == 10
        @user.print_out("You've tied!")
        game_over
      end
    end
  end

  def game_over
    @turn_counter = 11
  end 
end
