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

	def get_input
		@input_counter += 1
		if @input_counter == 1
			10
		else
			2
		end
	end
end

describe User do
	before :each do
		@board = Board.new
		@mock_user_interface = MockUserInterface.new
		@user = User.new(@board,@mock_user_interface)
	end

describe "#player_turn" do

		it "prints out a message asking the user where to place their x" do
			@user.player_turn
			@mock_user_interface.print_out_array[0].should eq "Where would you like to place your X?"
		end

		it "should tell the user if they've input an invalid move" do
			@user.player_turn
			@mock_user_interface.print_out_array[1].should eq "Sorry, that is not a valid move, please try again."
		end

		it "should return the user's position" do
			@user.player_turn.should eq [2,"X"]
		end
	end
end
