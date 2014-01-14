class Play
	
	def initialize(user, game)
		@user = user
		@game = game
	end
  
	def start_playing #a user playing several games
	  response = "yes"
	  until response != "yes"
		  play_game
		  @user.print_out("Game over! Would you like to start a new game?") #should this be a funtion of the Game class?
		  response = @user.get_input
	  end
	  @user.print_out("Thanks for playing! Goodbye!")
	end

	def play_game #a user playing one game
    @board = Board.new
    @game.reset(@board)
    @game.print_welcome
    # who_goes_first?
    while @game.in_progress?
      @game.take_a_turn
      @game.print_board
      @game.change_turn
      @game.check_for_winner
    end
  end
end