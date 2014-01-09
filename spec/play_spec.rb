require 'spec_helper'

describe Play do
	before :all do
		@play = Play.new
	end

	describe "#new" do
		it "should create a play object" do
			@play.should be_an_instance_of Play 
   	end

   	it "should initialize with a new UserInterface object" do
     @play.user.should be_an_instance_of UserInterface
   	end
	end

	describe "#start_playing" do
	
		# it "should create a new Board" do

		# end

		# it "should create a new Game" do 
		# 	pending
		# end
    
  #   it "should call the play_game method on the @game object" do
  #   	pending
  #   end
    
		it "should not repeat the loop if the user input is 'no'" do
			pending
		end
	end
end
