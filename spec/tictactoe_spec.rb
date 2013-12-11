require 'spec_helper'

describe TicTacToe do 
  before :each do
    @game = TicTacToe.new
  end
  
  describe "#new" do
    it "creates a new Tic-tac-toe game"
      @game.should be_an_instance_of TicTacToe
   end
end