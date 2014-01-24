require 'spec_helper'

class GameMockUserInterface
	attr_reader :print_out_array
	attr_accessor :input_counter
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
			"test"
		elsif @input_counter == 2
			"first"
		elsif @input_counter == 3
			"second"
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

class MockPlayer
	def initialize(board, user_interface)
		@board = board
		@user_interface = user_interface
	end
end

class Game #need to get rid of this! it's changing the behavior of the class?
	attr_accessor :turn_counter
end

describe Game do
	before :each do
		@mock_user_interface = GameMockUserInterface.new
		@game = Game.new(@mock_user_interface)
		@mock_play = MockPlay.new(@mock_user_interface, @game)
		@board = @mock_play.board
		@computer = Computer.new(@board, @user_interface)
    @human_user = HumanUser.new(@board, @user_interface)
	end

	describe "#print_welcome" do
		before :each do
			@game.reset([@human_user, @computer], @board)
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
			@game.reset([@human_user, @computer], @board)
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
			@player1 = MockPlayer.new(@board, @mock_user_interface)
			@player2 = MockPlayer.new(@board, @mock_user_interface)
			@game.reset([@player1, @player2], @board)
		end		

		it "iterates through both players and runs player_turn on each" do			
			@player1.should_receive(:player_turn).and_return([1, "X"])
			@player2.should_receive(:player_turn).and_return([5, "O"])
			@game.take_a_turn([@player1, @player2])
			@game.board.board.should == {1 => "X", 2 => " ", 3 => " ", 4 => " ", 5 => "O", 6 => " ", 7 => " ", 8 => " ", 9 => " "}
		end
	end

	describe "#in_progress?" do
		it "returns true if the turn_counter is less than 5" do
			@game.reset([@human_user, @computer], @board)
			@game.in_progress?.should eq true
		end

		it "returns false if the turn_counter is greater than or equal to 5" do
			@game.reset([@human_user, @computer], @board)
			5.times {@game.change_turn}
			@game.in_progress?.should eq false
		end
	end

	describe "#change_turn" do
		before :each do 
			@game.reset([@human_user, @computer], @board)
			@game.change_turn
		end

		it "should add 1 to the turn counter" do
			@game.turn_counter.should eq 1 
		end
	end

	describe "#check_for_winner" do
    before :each do
      @game.reset([@human_user, @computer], @board)
    end

    it "should print that the user has won" do
      @game.board.update_board(1,"X")
      @game.board.update_board(2,"X")
      @game.board.update_board(3,"X")
      @game.check_for_winner
      @mock_user_interface.print_out_array[0].should eq "Oops, it looks like you win!  That wasn't supposed to happen :|"
    end

    it "should print that the computer has won" do
      @game.board.update_board(1,"O")
      @game.board.update_board(2,"O")
      @game.board.update_board(3,"O")
      @game.check_for_winner
      @mock_user_interface.print_out_array[0].should eq "The computer wins!"
    end

    it "should print that they have tied" do
      @game.turn_counter = 5
      @game.check_for_winner
      @mock_user_interface.print_out_array[0].should eq "You've tied!"
    end
  end

	describe "#game_over" do
		it "should end the game by setting the turn counter to 6" do
			@game.game_over
			@game.turn_counter.should eq 6
		end	
	end

	describe "#who_goes_first?" do
		it "should print out to ask if the human user would like to go first or second" do
			@game.who_goes_first?([@human_user,@computer])
			@mock_user_interface.print_out_array[0].should eq "Would you like to go first or second? Please enter 'first' or 'second'."
		end

		it "should get input from the human user" do
			@game.who_goes_first?([@human_user,@computer])
			@mock_user_interface.input_counter.should == 2
		end

		it "should continue asking the user, until they put 'first' or 'second'" do
			@game.who_goes_first?([@human_user,@computer])
			@mock_user_interface.print_out_array[1].should eq "Would you like to go first or second? Please enter 'first' or 'second'."
		end

		it "should set the first player to human_user if the user wants to go first" do
			@game.who_goes_first?([@human_user,@computer]).should == [@human_user, @computer]
		end

		it "should set the first player to computer if the user wants to go second" do
			@mock_user_interface.input_counter = 2
			@game.who_goes_first?([@human_user, @computer]).should == [@computer, @human_user]
		end
	end
end











