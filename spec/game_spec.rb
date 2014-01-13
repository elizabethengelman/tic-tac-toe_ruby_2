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

class MockPlay
	attr_reader :board
	def initialize(user,game)
		@mock_user = user
		@game = game
		@board = Board.new
	end
end

class Game
	attr_reader :turn_counter
	attr_accessor :turn
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

	describe "#play_game" do
		before :each do
			@game.reset(@mock_play.board)
			@game.play_game
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

		# it "repeats the loop while the turn counter is less than 10" do
		# end

		it "calls the change_turn method" do
			@game.should_receive(:game_check)
			@game.play_game
		end

		# it "calls the game_check method" do
		# end
	end

	describe "#player_turn" do
		before :each do 
			@game.reset(@mock_play.board)
			@game.player_turn
		end

		it "prints out a message asking the user where to place their x" do
			@mock_user.print_out_array[0].should eq "Where would you like to place your X?"
		end

		# it "should continue the loop until the user enters a valid move" do
		# end

		# it "should return the player's position" do
		# end
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
	
	# describe "#game_check" do
	# end

	describe "#game_over" do
		it "should end the game by setting the turn counter to 11" do
			@game.game_over
			@game.turn_counter.should eq 11
		end	
	end
end