require 'spec_helper'

class FakeUserInterface #needed to changed the name of this from MockUserInterface because
	#i also use a MockUserInterface in the Game tests, which behaves differently than this one needs to
	attr_reader :print_out_called, :print_out_counter, :print_out_array, :get_input_counter
	attr_accessor :input
	def initialize
		@get_input_counter = 0
		@print_out_counter = 0
		@print_out_array = []
	end

	def print_out(output)
		@print_out_counter += 1
		@print_out_array << output
	end

	def get_input
		if @get_input_counter >= 1
 			@input = "no"
		else
			 @input = "yes"
		end
		@get_input_counter += 1
		@input
	end
end

class MockGame
	attr_reader :reset_called, :print_welcome_called, :take_a_turn_counter, 
							:print_board_counter, :change_turn_counter, :check_winner_counter,
							:user, :computer, :who_goes_first_counter
	def initialize
		@progress_counter = 0
		@take_a_turn_counter = 0
		@print_board_counter = 0
		@change_turn_counter = 0
		@check_winner_counter = 0
		@who_goes_first_counter = 0
	end

	def reset(players, board)
		@reset_called = true
	end

	def print_welcome
		@print_welcome_called = true
	end

	def in_progress?
		if @progress_counter >= 2
			progress = false
		else
			progress = true
		end
		@progress_counter += 1
		progress
	end

	def take_a_turn(player)
		@take_a_turn_counter += 1
	end

	def print_board
		@print_board_counter += 1
	end

	def change_turn(current_user_index)
		@change_turn_counter += 1
	end

	def check_for_winner
		@check_winner_counter += 1
	end

	def who_goes_first?
		@who_goes_first_counter += 1
	end
end

describe GameLoop do
	before :each do
		@mock_user_interface = FakeUserInterface.new
		@mock_game = MockGame.new
		@game_loop = GameLoop.new(@mock_user_interface, @mock_game)
	end
  
	describe "#start_playing" do

    it "should call the play_game method" do
      @game_loop.should_receive(:play_game).twice
      @game_loop.start_playing
    end

		it "should print out a message asking if the user would like to play again" do
			@game_loop.start_playing
			@mock_user_interface.print_out_array[0].should eq "Game over! Would you like to start a new game?"
		end

		it "should print out a goodbye message after the loop" do
			@game_loop.start_playing
			@mock_user_interface.print_out_array[2].should eq "Thanks for playing! Goodbye!"
		end

		it "should call the print_out method 3 times" do
			@game_loop.start_playing
			@mock_user_interface.print_out_counter.should eq 3 
		end

		it "should call the get_input method 2 times" do
			@game_loop.start_playing
			@mock_user_interface.get_input_counter.should eq 2
		end
	end

	describe "#play_game" do
		before :each do 
			@game_loop.play_game
		end

    it "should call the reset method" do
    	@mock_game.reset_called.should equal true
    end

    it "should call the print_welcome method" do
    	@mock_game.print_welcome_called.should equal true
    end

    it "should call the take_a_turn method each game" do
    	@mock_game.take_a_turn_counter.should eq 2
    end

    it "should call the change turn method" do
    	@mock_game.change_turn_counter.should eq 2
    end

    it "should call the check_for_winner method" do
    	@mock_game.check_winner_counter.should eq 2
    end

    it "should call the who_goes_first? method" do
    	@mock_game.who_goes_first_counter.should eq 1
    end
	end
end
