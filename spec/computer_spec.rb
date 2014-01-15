require 'spec_helper'

describe Computer do
	before :each do
		@board = Board.new
		@computer = Computer.new(@board)
	end

	describe "#computer_turn" do

		before :each do
			@computer.computer_turn
		end

		it "should return 5 if that space is available" do
			@computer.computer_turn.should equal 5
		end

		it "should run the find_computer_move method if 5 is not available" do
			@board.update_board(5,"X")
			@computer.should receive(:find_computer_move)
			@computer.computer_turn
		end	
	end

	describe "#find_computer_move" do

		it "should return the winning move if the computer has 2 O's in a line" do
			@board.update_board(1,"O")
			@board.update_board(2,"O")
			@computer.find_computer_move.should eq 3
		end

		it "should return a blocking move, if the user has 2 X's in a line" do
			@board.update_board(1,"X")
			@board.update_board(4,"X")
			@computer.find_computer_move.should eq 7
		end

		it "should begin building a win, if the computer has 1 O in a line" do
			@board.update_board(1,"X")
			@computer.find_computer_move.should eq 2
		end
	end
end	