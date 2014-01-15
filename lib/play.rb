class Play
	
	def initialize(user_interface, game)
		@user_interface = user_interface
		@game = game
	end
  
	def start_playing #a user playing several games
	  response = "yes"
	  until response != "yes"
		  play_game
		  @user_interface.print_out("Game over! Would you like to start a new game?") #should this be a funtion of the Game class?
		  response = @user_interface.get_input
	  end
	  @user_interface.print_out("Thanks for playing! Goodbye!")
	end

	def play_game #a user playing one game
    @game.reset
    @user = @game.user
    @computer = @game.computer
    @game.print_welcome
    while @game.in_progress?
      [@user, @computer].each do |player|
      	@game.take_a_turn(player)
      end
      @game.print_board
      @game.change_turn
      @game.check_for_winner
    end
  end
end