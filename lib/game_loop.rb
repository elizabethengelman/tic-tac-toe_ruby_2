class GameLoop
	
	def initialize(user_interface, game)
		@user_interface = user_interface
		@game = game
		@current_player = 0
	end
  
	def start_playing
	  response = "yes"
	  until response != "yes"
		  play_game
		  @user_interface.print_out("Game over! Would you like to start a new game?") #should this be a funtion of the Game class?
		  response = @user_interface.get_input
	  end
	  @user_interface.print_out("Thanks for playing! Goodbye!")
	end

	def play_game
    board = Board.new
    computer = Computer.new(board, @user_interface)
    human_user = HumanUser.new(board, @user_interface)
    players = [human_user, computer]
    @game.reset(players, board)
    @game.print_welcome
    current_player_index = @game.who_goes_first?
    while @game.in_progress?
			current_player = players[current_player_index]
	    @game.take_a_turn(current_player)
    	current_player_index = @game.change_turn(current_player_index)
      @game.check_for_winner
    end
  end
end