class Play
	attr_reader :user #added this so that I could test that a new user is created when
										#a new Play object is initialized - this seems like cheating
	def initialize(user, game)
		@user = user
		@game = game
	end
  
	def start_playing #a user playing several games
	  response = "yes"
	  until response != "yes"
    	@board = Board.new
      @game.reset(@board)
		  play_game
		  @user.print_out("Game over! Would you like to start a new game?")
		  response = @user.get_input
	  end
	  @user.print_out("Thanks for playing! Goodbye!")
	end

	def play_game #a user playing one game
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