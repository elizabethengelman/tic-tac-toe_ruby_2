require 'spec_helper'

describe Play do
	before :all do
		@play = Play.new
	end

	describe "#new" do
		it "should create a play object" do
			@play.should be_an_instance_of Play 
	  end
	end
end
