require 'spec_helper'

describe UserInterface do
	before :all do
		@user = UserInterface.new
	end

	describe "#get_input" do
		it "should get input from the user via STDIN" do
			pending
			@user.should be_an_instance_of UserInterface 
	  end
	end

	describe "#print_out" do
		it "should print out the output" do
			pending
		end
	end
end
