class Game
  SPACE = " "
  attr_reader :board, :computer, :user
  
  def initialize(user_interface)
    @user_interface = user_interface
  end

  def reset(players, board)
    @board = board
    @turn_counter = 0   
    @player1 = players[0]
    @player2 = players[1]
  end


  def print_welcome
    @user_interface.print_out("Welcome to tic-tac-toe! The board is numbered as follows.")
    @user_interface.print_out(@board.print_example_board)
    @user_interface.print_out(@board.print_board)
  end

  def print_board
    @user_interface.print_out(@board.print_board)
  end

  def take_a_turn
    [@player1, @player2].each do |player|
      move = player.player_turn
      @board.update_board(move[0],move[1])
    end
  end

  #set expectations on the array that is being passed in
  #and then check the state afterward
  
  def in_progress?
    @turn_counter < 5
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

  def change_turn
    @turn_counter +=1
  end

  def check_for_winner #is this a function of game, or the board?
    @board.possible_wins.each do |line|
      if @board.times_in_line(line, "X") == 3
        @user_interface.print_out("Oops, it looks like you win!  That wasn't supposed to happen :|")
        game_over
      elsif @board.times_in_line(line, "O") == 3
        @user_interface.print_out("The computer wins!")
        game_over
      elsif @turn_counter == 5
        @user_interface.print_out("You've tied!")
        game_over
      end
    end
  end

  def game_over
    @turn_counter = 6
  end 
end
