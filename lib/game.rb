class Game
  SPACE = " "
  attr_reader :turn, :board
  
  def initialize(user_interface)
    @user_interface = user_interface
  end

  def reset
    @board = Board.new
    @turn_counter = 0   
    @turn = :human 
    @computer = Computer.new(@board)
    @user = User.new(@board, @user_interface)
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
    if @turn == :human
      @board.update_board(@user.user_turn, "X")
    else 
      @user_interface.print_out("The computer is playing...")
      @board.update_board(@computer.computer_turn, "O")
    end
  end
  
  def in_progress?
    if @turn_counter < 10
      true
    else
      false
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

  def change_turn
    @turn_counter +=1
    if @turn == :human
      @turn = :computer
    else
      @turn = :human
    end
  end

  def check_for_winner
    @board.possible_wins.each do |line|
      if @board.times_in_line(line, "X") == 3
        @user_interface.print_out("Oops, it looks like you win!  That wasn't supposed to happen :|")
        game_over
      elsif @board.times_in_line(line, "O") == 3
        @user_interface.print_out("The computer wins!")
        game_over
      elsif @turn_counter == 10
        @user_interface.print_out("You've tied!")
        game_over
      end
    end
  end

  def game_over
    @turn_counter = 11
  end 
end
