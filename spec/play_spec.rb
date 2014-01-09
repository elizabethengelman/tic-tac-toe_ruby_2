require 'spec_helper'

class MockUser

	def initialize
		@counter = 0
	end

	def print_out(output)
	end

	def get_input
		if @counter >= 1
 			input = "no"
		else
			 input = "yes"
		end
		@counter += 1
		input
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
    
    it "should call the play_game method on the @game object" do
      @play.start_playing
    	@mock_game.play_game_called.should equal true
    end

    it "should call the reset method" do
    	@play.start_playing
    	@mock_game.reset_called.should equal true
    end
    
		it "should not repeat the loop if the user input is 'no'" do
			@play.start_playing
			@mock_game.play_game_called_counter.should equal 2

		end
	end
end
