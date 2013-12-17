require 'spec_helper'

describe Game do
	before :all do
		@board = Board.new
		@user = UserInterface.new
		@game = Game.new(@board, @user)
	end

	describe "#new" do
		it "should create a game object" do
			@game.should be_an_instance_of Game 
	  end
	end
end
