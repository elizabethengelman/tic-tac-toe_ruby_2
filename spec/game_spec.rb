require 'spec_helper'

class MockUser
	attr_reader :print_out_array
	def initialize
		@print_out_array = []
		@input_counter = 0
	end
	
	def print_out(output)
		@print_out_array << output
	end

	def get_input
		@input_counter += 1
		if @input_counter == 1
			1
		elsif @input_counter == 2
			2
		elsif @input_counter == 3
			9
		end
	end
end

class NewMockUser
	attr_reader :print_out_array
	def initialize
		@print_out_array = []
		@input_counter = 0
	end
	
	def print_out(output)
		@print_out_array << output
	end

	def get_input
		@input_counter += 1
		if @input_counter == 1
			10
		else
			2
		end
	end
end

class MockPlay
	attr_accessor :board
	def initialize(user,game)
		@mock_user = user
		@game = game
		@board = Board.new
	end
end

class Game #need to get rid of this! it's changing the behavior of the class
	attr_accessor :turn_counter, :turn
end

describe Game do
	before :each do
		@mock_user = MockUser.new
		@game = Game.new(@mock_user) #this is confusing that both game and play receive a user object
		@mock_play = MockPlay.new(@mock_user, @game)
	end

	describe "#print_welcome" do
		before :each do
			@game.reset
			@game.print_welcome
		end

		it "prints out a welcome message" do
			@mock_user.print_out_array[0].should eq "Welcome to tic-tac-toe! The board is numbered as follows."
		end

		it "prints out an example board" do
			@mock_user.print_out_array[1].should eq [
      "1 | 2 | 3",
      "_________",
      "4 | 5 | 6",
      "_________",
      "7 | 8 | 9",
      "",
      "---------------",
      ""
      ]
		end

		it "prints out the empty board" do
			@mock_user.print_out_array[2].should eq [
      "  |   |  ",
      "_________",
      "  |   |  ",
      "_________",
      "  |   |  "
  	  ]
		end
	end

	describe "#print_board" do
		it "prints out the current board" do
			@game.reset
			@game.board.board[1] = "X"
			@game.print_board
			@mock_user.print_out_array[0].should eq [
      "X |   |  ",
      "_________",
      "  |   |  ",
      "_________",
      "  |   |  "
  	  ]
		end
	end

	describe "#take_a_turn" do
		before :each do 
			@game.reset
		end
		it "updates the board with player_turn if it's the human's turn" do
			@game.take_a_turn.should eq "X"
		end

		it "updates the board with computer_turn if it's the computer's turn" do
			@game.change_turn
			@game.take_a_turn.should eq "O"
		end
	end

	describe "#in_progress?" do
		it "returns true if the turn_counter is less than 10" do
			@game.turn_counter = 8 #work on a better way to do this
			@game.in_progress?.should eq true
		end

		it "returns false if the turn_counter is greater than 10" do
			@game.turn_counter = 11 #work on a better way to do this
			@game.in_progress?.should eq false
		end
	end

	describe "#player_turn" do
		before :each do 
			@second_mock_user = NewMockUser.new
			@second_game = Game.new(@second_mock_user)
			@second_mock_play = MockPlay.new(@second_mock_user, @second_game)
			@second_game.reset
			@second_game.player_turn
		end

		it "prints out a message asking the user where to place their x" do
			@second_mock_user.print_out_array[0].should eq "Where would you like to place your X?"
		end

		it "should tell the user if they've input an invalid move" do
			@second_mock_user.print_out_array[1].should eq "Sorry, that is not a valid move, please try again."
		end

		it "should return the player's position" do
			@second_game.player_turn.should eq 2	
		end
	end

	describe "#computer_turn" do

		before :each do
			@game.reset
			@game.computer_turn
		end

		it "should print out a message that the computer is playing" do
			@mock_user.print_out_array[0].should eq "The computer is playing..."
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

	describe "#change_turn" do
		before :each do 
			@game.reset
			@game.change_turn
		end

		it "should add 1 to the turn counter" do
			@game.turn_counter.should eq 1
		end
    
    it "should change the turn to :computer if it's currently :human" do
			@game.turn.should eq :computer
		end

		it "should change the turn to :human if it's currrently :computer" do
			@game.turn = :computer
			@game.change_turn
			@game.turn.should eq :human
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

	describe "#times_in_line" do
		it "should find how many times a certain mark(O or X) is in a specific line" do
			@game.reset
			@game.board.board[1] = "X"
			@game.board.board[2] = "X"
			@game.times_in_line([1,2,3], "X").should eq 2
		end

		it "should return 0, if the mark does not appear in the specific line" do
			@game.reset
			@game.times_in_line([4,5,6], "X").should eq 0
		end
	end

	describe "#empty_in_line" do
		before :each do 
			@game.reset
			@possible_winning_line = @game.board.possible_wins[0]
		end

		it "should return the index of the first empty space in the line" do
			@game.empty_in_line(@possible_winning_line).should eq 1
		end

		it "should return the next available space if the first space is full" do
			@game.board.board[1] = "X"
			@game.empty_in_line(@possible_winning_line).should eq 2
		end

		it "should return nil if there is not empty space in the line" do
			pending "This doesn't work - how does this method work?"
			@mock_play.board.update_board(1,"X")
			@mock_play.board.update_board(2,"X")
			@mock_play.board.update_board(3,"O")
			@game.empty_in_line([1,2,3]).should eq nil
		end
	end
	
	describe "#valid_move?" do 
		before :each do
			@game.reset  #have to do this first so that the game object has access to the new board object
		end

		it "should return true if the space is open" do
			@game.valid_move?(1).should equal true
		end

		it "should return false if the space is not open" do
			@game.board.board[1] = "X"
			@game.valid_move?(1).should equal false
		end

		it "should return false if the move is not part of the board" do
			@game.valid_move?(10).should equal false
		end
	end
	
	describe "#check_for_winner" do
		before :each do
			@game.reset
		end

		it "should print that the user has won" do
			@game.board.board[1] = "X"
			@game.board.board[2] = "X"
			@game.board.board[3] = "X"
			@game.check_for_winner
			@mock_user.print_out_array[0].should eq "Oops, it looks like you win!  That wasn't supposed to happen :|"
		end

		it "should print that the computer had won" do
			@game.board.board[1] = "O"
			@game.board.board[2] = "O"
			@game.board.board[3] = "O"
			@game.check_for_winner
			@mock_user.print_out_array[0].should eq "The computer wins!"
		end

		it "should print that they have tied" do
			@game.turn_counter = 10
			@game.check_for_winner
			@mock_user.print_out_array[0].should eq "You've tied!"
		end
	end

	describe "#game_over" do
		it "should end the game by setting the turn counter to 11" do
			@game.game_over
			@game.turn_counter.should eq 11
		end	
	end
end