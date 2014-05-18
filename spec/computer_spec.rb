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
end

class MockHumanUser
	attr_accessor :mark
	def initialize(board, mock_user_interface)
		@mark = "X"
	end
end


describe Computer do
	before :each do
		@board = Board.new
		@mock_user_interface = MockUserInterface.new
		@mock_human_user = MockHumanUser.new(@board, @mock_user_interface)
		@computer = Computer.new(@board, @mock_user_interface, @mock_human_user)
	end

  def update_board_for_test(moves_to_update)
    moves_to_update.each do |key, value|
      @board.update_board(key, value)
    end
  end

  describe "#player_turn" do

		before :each do
			@computer.player_turn
		end

		it "should print out a message that the computer is playing" do
			@mock_user_interface.print_out_array[0].should eq "The computer is playing..."
		end

		it "should return 5 if that space is available" do
			@computer.player_turn.should eq [5,"O"]
		end

		it "should run the find_computer_move method if 5 is not available" do
			@board.update_board(5,"X")
			@computer.should receive(:find_computer_move)
			@computer.player_turn
		end
	end

	describe "#find_computer_move" do

		it "should return the winning move if the computer has 2 marks in a line" do
			update_board_for_test({1 => "O", 2 => "O"})
			@computer.find_computer_move.should eq 3
		end

		it "should return a blocking move, if the user has 2 marks in a line" do
			update_board_for_test({1 => "X", 4 => "X"})
			@computer.find_computer_move.should eq 7
		end

		it "should begin building a win, if the computer has 1 mark in a line" do
			@board.update_board(1,"O")
			@computer.find_computer_move.should eq 2
		end

		it "if no other moves avaible, it should return 3" do
			@board.update_board(1, "X")
			@computer.find_computer_move.should eq 3
		end
	end

	describe "#assign_computer_mark" do
		it "should return X if the human has already chosen to use 'O'" do
			@mock_human_user.mark = "O"
			@computer.assign_computer_mark.should == "X"
		end
	end

  describe "#who_wins?" do
    it "returns 'O' when 'O' is the winner" do
      update_board_for_test({1 => "O", 2 => "O", 3 => "O"})
      @computer.who_wins?.should eq "O"
    end

    it "returns 'X' if 'X' wins" do
      update_board_for_test({1 => "X", 2 => "X", 3 => "X"})
      @computer.who_wins?.should eq "X"
    end

    it "returns nil if its a tie game" do
      update_board_for_test({ 1 => "X", 2 => "O", 3 => "X",
                              4 => "O", 3 => "X", 4 => "O",
                              5 => "O", 4 => "X", 5 => "O"})
      @computer.who_wins?.should eq nil
    end
  end

  describe "#get_score" do
    it "returns 1 if the move leads to a win for the current player" do
      update_board_for_test({1 => "O", 2 => "O", 3 => "O"})
      @computer.get_score(@board, "O").should == 1
    end

    it "returns -1 if the move leads to a loss for the current player" do
      update_board_for_test({1 => "O", 2 => "O", 3 => "O"})
      @computer.get_score(@board, "X").should == -1
    end

    it "returns a 0 of the move leads to tie" do
      update_board_for_test({ 1 => "X", 2 => "O", 3 => "X",
                              4 => "O", 3 => "X", 4 => "O",
                              5 => "O", 4 => "X", 5 => "O"})
      @computer.get_score(@board, "O").should == 0
    end
  end


end
