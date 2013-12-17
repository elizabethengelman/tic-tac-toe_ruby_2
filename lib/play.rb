class Play
	def initialize
		@user = UserInterface.new
	end
  
	def start_playing
		response = "yes"
		until response != "yes"
      @board = Board.new
      @game = Game.new(@board, @user)
			@game.play_game
			@user.print_out("Game over! Would you like to start a new game?")
			response = @user.get_input
		end
		@user.print_out("Thanks for playing! Goodbye!")
	end
end