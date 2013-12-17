require 'spec_helper'

describe TicTacToe do 
	before :all do 
		@tictactoe = TicTacToe.new 
	end

	describe "#new" do
      it "returns a new TicTacToe object " do
        @tictactoe.should be_an_instance_of TicTacToe
      end
    end
	
end