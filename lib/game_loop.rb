class GameLoop
	
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
    board = Board.new
    computer = Computer.new(board, @user_interface)
    human_user = HumanUser.new(board, @user_interface)
    players = [human_user, computer]
    @game.reset(players, board)
    @game.print_welcome
    players = @game.who_goes_first?([human_user, computer])
    while @game.in_progress?
      @game.take_a_turn(players)
      @game.change_turn
      @game.check_for_winner
    end
  end
end