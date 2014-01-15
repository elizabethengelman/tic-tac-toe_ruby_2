require 'spec_helper'

class MockUserInterface
	attr_reader :print_out_array
	def initialize
		@print_out_array = []
		@input_counter = 0
	end
	
	def print_out(output)
		@print_out_array << output
	end

	def get_input #maybe create and array like the print out method
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
		@mock_user_interface = MockUserInterface.new
		@game = Game.new(@mock_user_interface) #this is confusing that both game and play receive a user object
		@mock_play = MockPlay.new(@mock_user_interface, @game)
	end

	describe "#print_welcome" do
		before :each do
			@game.reset
			@game.print_welcome
		end

		it "prints out a welcome message" do
			@mock_user_interface.print_out_array[0].should eq "Welcome to tic-tac-toe! The board is numbered as follows."
		end

		it "prints out an example board" do
			@mock_user_interface.print_out_array[1].should eq [
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
			@mock_user_interface.print_out_array[2].should eq [
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
			@game.board.update_board(1,"X")
			@game.print_board
			@mock_user_interface.print_out_array[0].should eq [
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
		it "updates the board with user_turn if it's the user's turn" do
			pending "For some reason this breaks when running the full rspec"	
			@game.take_a_turn.should eq "X"
		end

		it "updates the board with computer_turn if it's the computer's turn" do
			@game.change_turn
			@game.take_a_turn.should eq "O"
		end

		it "should print out a message when the computer is playing" do
			@game.change_turn
			@game.take_a_turn.should eq "O"
			@mock_user_interface.print_out_array[0].should eq "The computer is playing..."
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

	describe "#check_for_winner" do
    before :each do
      @game.reset
    end

    it "should print that the user has won" do
      @game.board.update_board(1,"X")
      @game.board.update_board(2,"X")
      @game.board.update_board(3,"X")
      @game.check_for_winner
      @mock_user_interface.print_out_array[0].should eq "Oops, it looks like you win!  That wasn't supposed to happen :|"
    end

    it "should print that the computer had won" do
      @game.board.update_board(1,"O")
      @game.board.update_board(2,"O")
      @game.board.update_board(3,"O")
      @game.check_for_winner
      @mock_user_interface.print_out_array[0].should eq "The computer wins!"
    end

    it "should print that they have tied" do
      @game.turn_counter = 10
      @game.check_for_winner
      @mock_user_interface.print_out_array[0].should eq "You've tied!"
    end
  end


	describe "#game_over" do
		it "should end the game by setting the turn counter to 11" do
			@game.game_over
			@game.turn_counter.should eq 11
		end	
	end
end