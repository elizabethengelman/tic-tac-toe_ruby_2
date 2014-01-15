describe "#computer_turn" do

		before :each do
			@game.reset
			@game.computer_turn
		end

		it "should return 5 if that space is available" do
			@game.computer_turn.should equal 5
		end

		it "should run the find_computer_move method if 5 is not available" do
			@game.board.board[5] = "X"
			@game.should receive(:find_computer_move)
			@game.computer_turn
		end	
	end

	describe "#find_computer_move" do
		before :each do
			@game.reset
		end

		it "should return the winning move if the computer has 2 O's in a line" do
			@game.board.board[1] = "O"
			@game.board.board[2] = "O"
			@game.find_computer_move.should eq 3
		end

		it "should return a blocking move, if the user has 2 X's in a line" do
			@game.board.board[1] = "X"
			@game.board.board[4] = "X"
			@game.find_computer_move.should eq 7
		end

		it "should begin building a win, if the computer has 1 O in a line" do
			@game.board.board[1] = "X"
			@game.find_computer_move.should eq 2
		end
	end
	
	describe "#check_for_winner" do
		before :each do
			@game.reset
		end

		it "should let the user know that they have" do
			@game.board.board[1] = "X"
			@game.board.board[2] = "X"
			@game.board.board[3] = "X"
			@game.check_for_winner
			@mock_user_interface.print_out_array[0].should eq "Oops, it looks like you win!  That wasn't supposed to happen :|"
		end

		it "should let the user know that the computer has won" do
			@game.board.board[1] = "O"
			@game.board.board[2] = "O"
			@game.board.board[3] = "O"
			@game.check_for_winner
			@mock_user_interface.print_out_array[0].should eq "The computer wins!"
		end

		it "should let the user know that they have tied" do
			@game.turn_counter = 10
			@game.check_for_winner
			@mock_user_interface.print_out_array[0].should eq "You've tied!"
		end
	end