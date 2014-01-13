require 'spec_helper'

class MockUser
	attr_reader :print_out_called, :print_out_counter, :print_out_array
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
	attr_reader :play_game_called, :reset_called, :play_game_called_counter
	def initialize
		@play_game_called_counter = 0
	end

	def reset(board)
		@reset_called = true
	end

	def print_welcome
	end

	def in_progress?
	end

	def take_a_turn
	end

	def print_board
	end

	def change_turn
	end

	def check_for_winner
	end

end

describe Play do
	before :each do
		@mock_user = MockUser.new
		@mock_game = MockGame.new
		@play = Play.new(@mock_user, @mock_game)
	end
  
	describe "#start_playing" do
    
    it "should call the reset method" do
    	@play.start_playing
    	@mock_game.reset_called.should equal true
    end

    it "should call the play_game method on the @game object" do
      @play.should_receive(:play_game).twice
      @play.start_playing
    end

		it "should print out a message asking if the user would like to play again" do
			@play.start_playing
			@mock_user.print_out_array[0].should eq "Game over! Would you like to start a new game?"
		end

		it "should print out a goodbye message after the loop" do
			@play.start_playing
			@mock_user.print_out_array[2].should eq "Thanks for playing! Goodbye!"
		end

		it "should call the print_out method 3 times" do
			@play.start_playing
			@mock_user.print_out_counter.should eq 3 
		end
	end
end
