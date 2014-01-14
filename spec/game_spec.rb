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
			1
		end
	end
end

class MockPlay
	attr_reader :board
	def initialize(user,game)
		@mock_user = user
		@game = game
		@board = Board.new
	end
end

class Game #need to get rid of this! it's changing the behavior of the class
	attr_accessor :turn_counter, :turn
end

class Board
	attr_accessor :board
end

describe Game do
	before :each do
		@mock_user = MockUser.new
		@game = Game.new(@mock_user)
		@mock_play = MockPlay.new(@mock_user, @game)
	end

	describe "#print_welcome" do
		before :each do
			@game.reset(@mock_play.board)
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
			@game.reset(@mock_play.board)
			@mock_play.board.board[1] = "X"
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
		it "updates the board with player_turn if it's the human's turn" do
		pending
		end

		it "updates the board with computer_turn if it's the computer's turn" do
		pending
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
			@game.reset(@mock_play.board)
			@game.player_turn
		end

		it "prints out a message asking the user where to place their x" do
			@mock_user.print_out_array[0].should eq "Where would you like to place your X?"
		end

		it "continues the loop until the user inputs a valid position" do
			@new_mock_user = NewMockUser.new
			@mock_play2 = MockPlay.new(@new_mock_user, @game)
			@game.reset(@mock_play2.board)
			@game.player_turn
			@new_mock_user.print_out_array[0].should eq "no"

		end

		it "should return the player's position" do
		end

	end

	describe "#computer_turn" do

		before :each do
			@game.reset(@mock_play.board)
			@game.computer_turn
		end

		it "should print out a message that the computer is playing" do
			@mock_user.print_out_array[0].should eq "The computer is playing..."
		end

		it "should return 5 if that space is available" do
			@game.computer_turn.should equal 5
		end

		it "should run the find_computer_move method if 5 is not available" do
			@mock_play.board.board[5] = "X"
			@game.should receive(:find_computer_move)
			@game.computer_turn
		end	
	end

	describe "#change_turn" do
		before :each do 
			@game.reset(@mock_play.board) 
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

	# describe "#find_computer_move" do
	# end

	# describe "#times_in_line" do
	# end

	# describe "#empty_in_line" do
	# end
	
	describe "#valid_move?" do 
		before :each do
			@game.reset(@mock_play.board)  #have to do this first so that the game object has access to the new board object
		end

		it "should return true if the space is open" do
			@game.valid_move?(1).should equal true
		end

		it "should return false if the space is not open" do
			@mock_play.board.board[1] = "X"
			@game.valid_move?(1).should equal false
		end

		it "should return false if the move is not part of the board" do
			@game.valid_move?(10).should equal false
		end
	end
	
	# describe "#check_for_winner" do
	# end

	describe "#game_over" do
		it "should end the game by setting the turn counter to 11" do
			@game.game_over
			@game.turn_counter.should eq 11
		end	
	end
end