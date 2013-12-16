class Game
  SPACE = " "
  def initialize(board_object, user_object)
    @board = board_object
    @user = user_object
    @turn = :human
    @turn_counter = 1    
  end

  def play_game
    # puts Kernel.caller.join("\n")
    @user.print_out("Welcome to tic-tac-toe! The board is numbered as follows.")
    @user.print_out(@board.print_example_board)
    @user.print_out(@board.print_board)

    while @turn_counter < 10
      if @turn == :human
        @board.update_board(player_turn, "X")
        change_turn
      else 
        @board.update_board(computer_turn, "O")
        change_turn
      end
      @user.print_out(@board.print_board)
      game_check
      puts "this is the turn counter: #{@turn_counter}"
    end
  end

  def player_turn
    @user.print_out("Where would you like to place your X?")
    position = gets.chomp.to_i
    if valid_move?(position)
      position
    else
      @user.print_out("Sorry, that is not a valid move, please try again.")
      player_turn
    end
  end

  def computer_turn
  	@user.print_out("The computer is playing...")
    sleep(0.5)
  	if @turn_counter == 2
  	  if @board.board[5] == SPACE
  	  	return 5
       else
       	return 3
       end
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
  	@board.possible_wins.each do |line|
  	  if times_in_line(line, "O") == 2
  	  	computer_move = empty_in_line(line)
        if computer_move
          return computer_move
        end
  	  end
  	end

  	@board.possible_wins.each do |line|
  	  if times_in_line(line, "X") == 2
  	  	computer_move = empty_in_line(line)
        if computer_move
          return computer_move
        end
  	  end
    end

    @board.possible_wins.each do |line|
      if times_in_line(line, "O") == 1
        computer_move = empty_in_line(line)
        if computer_move
          return computer_move
        end
      end
    end
    
    @board.board.each do |key, value|
      if value == " "
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
      end
    end

    @board.possible_wins.each do |line|
      if times_in_line(line, "O") == 3
        @user.print_out("The computer wins!")
        game_over
      end
    end

    if @turn_counter == 10
      @user.print_out("You've tied!")
      game_over
    end
  end

  def game_over
    @turn_counter = 10
  end 
end
