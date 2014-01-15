class User
	def initialize(board, user_interface) 
		@board = board
		@user_interface = user_interface
	end

  def player_turn
    @user_interface.print_out("Where would you like to place your X?")
    position = @user_interface.get_input.to_i
    until @board.valid_move?(position)
      @user_interface.print_out("Sorry, that is not a valid move, please try again.")
      position = @user_interface.get_input.to_i
    end
    [position, "X"]
  end
end