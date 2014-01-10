require 'spec_helper'

class MockUser
	attr_reader :print_out_called, :print_out_counter
	attr_accessor :input
	def initialize
		@get_input_counter = 0
		@print_out_counter = 0
	end

	def print_out(output)
		@print_out_counter += 1
		@print_out_called = output
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

	def play_game
		@play_game_called = true
		@play_game_called_counter += 1
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
      @play.start_playing
    	@mock_game.play_game_called.should equal true
    end

		it "should not repeat the loop if the user input is 'no'" do
			@play.start_playing
			@mock_game.play_game_called_counter.should equal 2
		end

		it "should call the print_out method" do
			@play.start_playing
			@mock_user.print_out_counter.should eq 3 
			# @mock_user.print_out_called.should eq "Game over! Would you like to start a new game?" how do i test that is prints out the right thing?
		end

		it "should print out a goodbye message after the loop" do
			@play.start_playing
			@mock_user.print_out_called.should eq "Thanks for playing! Goodbye!"
		end
	end
end
