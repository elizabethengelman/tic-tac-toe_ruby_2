require 'spec_helper'

describe Board do
	before :each do
		@test_board = Board.new
	end

	describe "#print_board" do
		it "should return the current board" do
			@test_board.print_board.should eq [
      "#{@test_board.board[1]} | #{@test_board.board[2]} | #{@test_board.board[3]}",
      "_________",
      "#{@test_board.board[4]} | #{@test_board.board[5]} | #{@test_board.board[6]}",
      "_________",
      "#{@test_board.board[7]} | #{@test_board.board[8]} | #{@test_board.board[9]}"
  	]
	  end
	end

	describe "print_example_board" do
		it "should return an example board" do
			@test_board.print_example_board.should eq [
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
	end

	# describe "#update_board"

  # describe "#times_in_line" do
  #   it "should find how many times a certain mark(O or X) is in a specific line" do
  #     @game.reset
  #     @game.board.board[1] = "X"
  #     @game.board.board[2] = "X"
  #     @game.times_in_line([1,2,3], "X").should eq 2
  #   end

  #   it "should return 0, if the mark does not appear in the specific line" do
  #     @game.reset
  #     @game.times_in_line([4,5,6], "X").should eq 0
  #   end
  # end


  describe "#empty_in_line" do
    before :each do 
      @game.reset
      @possible_winning_line = @game.board.possible_wins[0]
    end

    it "should return the index of the first empty space in the line" do
      @game.empty_in_line(@possible_winning_line).should eq 1
    end

    it "should return the next available space if the first space is full" do
      @game.board.board[1] = "X"
      @game.empty_in_line(@possible_winning_line).should eq 2
    end

    it "should return nil if there is not empty space in the line" do
      pending "This doesn't work - how does this method work?"
      @mock_play.board.update_board(1,"X")
      @mock_play.board.update_board(2,"X")
      @mock_play.board.update_board(3,"O")
      @game.empty_in_line([1,2,3]).should eq nil
    end
  end

    describe "#valid_move?" do 
    before :each do
      @game.reset  #have to do this first so that the game object has access to the new board object
    end

    it "should return true if the space is open" do
      @game.valid_move?(1).should equal true
    end

    it "should return false if the space is not open" do
      @game.board.board[1] = "X"
      @game.valid_move?(1).should equal false
    end

    it "should return false if the move is not part of the board" do
      @game.valid_move?(10).should equal false
    end
  end
end
