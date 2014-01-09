class Play
	attr_reader :user #added this so that I could test that a new user is created when
										#a new Play object is initialized - this seems like cheating
	def initialize(user, game)
		@user = user
		@game = game
	end
  
	def start_playing
	  response = "yes"
	  until response != "yes"
    	@board = Board.new
      @game.reset(@board)
			@game.play_game
			@user.print_out("Game over! Would you like to start a new game?")
			response = @user.get_input
	  end
	  @user.print_out("Thanks for playing! Goodbye!")
	end
end