require 'spec_helper'

class MockUser
	attr_reader :print_out_counter
	def initialize
		@print_out_counter = 0
	end
	def print_out
		@print_out_counter += 1
	end
end

describe Game do
	before :each do
		@mock_user = MockUser.new
		@game = Game.new(@mock_user)
	end

	describe "#play_game" do
		"it should call the print_out method 3 times" do
			@game.play_game
			@mock_user.print_out_counter
		end

	end

	# describe "#who_goes_first?" do
	# end

	# describe "#user_first" do
	# 	it "should return :human" do
	# 		@game.user_first.should equal :human
	# 	end
	# end

	# describe "#user_second" do
	# 	it "should return :computer" do
	# 		@game.user_second.should equal :computer
	# 	end
	# end

	# describe "#player_turn" do
	# end

	# describe "#computer_turn" do
		# before do 
		# 	$stdout.stub(:write) #LOOK at this again!
		# end

		# it "should return 5 if that space is available" do
		# 	pending
		# 	@game.computer_turn.should equal 5
		# end

		# it "should run the find_computer_move method if 5 is not available" do
		# 	@board.board[5] = "X"
		# 	@game.should receive(:find_computer_move)
		# 	@game.computer_turn
		# end	
	# end

	# describe "#change_turn" do
	# 	before :each do 
	# 		@game.change_turn
	# 	end

		# it "should add 1 to the turn counter" do
		# 	@game.turn_counter.should eq 2 #what is a better way to do this - i added an attr_read
		# 																 # so that I could access the specific turn counter in this 
		# 														 # instance of game. if i just use @turn_counter - what is this?
		# end
    
  #   it "should change the turn to :human if it's currrently :computer" do
		# 	@game.turn.should eq :human
		# end
		
		# it "should change the turn to :computer if it's currently :human" do
		# 	@game.turn.should eq :computer
		# end

		
	# end

	describe "#find_computer_move" do
	end

	describe "#times_in_line" do
	end

	describe "#empty_in_line" do
	end
	
	# describe "#valid_move?" do 
	# 	it "should return true if the space is open" do
	# 		@board.board[1] = " "
	# 		@game.valid_move?(1).should equal true
	# 	end

	# 	it "should return false if the space is not open" do
	# 		@board.board[1] = "X"
	# 		@game.valid_move?(1).should equal false
	# 	end

	# 	it "should return false if the move is not part of the board" do
	# 		@game.valid_move?(10).should equal false
	# 	end
	# end
	
	describe "#game_check" do
	end

	describe "#game_over" do
		it "should end the game by setting the turn counter to 11" do
			@game.game_over.should equal 11
		end	
	end
end
