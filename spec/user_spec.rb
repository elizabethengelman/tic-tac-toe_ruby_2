describe "#player_turn" do
		before :each do 
			@second_mock_user_interface = SecondMockUserInterface.new
			@second_game = Game.new(@second_mock_user_interface)
			@second_mock_play = MockPlay.new(@second_mock_user_interface, @second_game)
			@second_game.reset
			@second_game.player_turn
		end

		it "prints out a message asking the user where to place their x" do
			@second_mock_user_interface.print_out_array[0].should eq "Where would you like to place your X?"
		end

		it "should tell the user if they've input an invalid move" do
			@second_mock_user_interface.print_out_array[1].should eq "Sorry, that is not a valid move, please try again."
		end

		it "should return the player's position" do
			@second_game.player_turn.should eq 2	
		end
	end
