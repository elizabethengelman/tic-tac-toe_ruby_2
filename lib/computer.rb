class Computer
  SPACE = " "
  
	def initialize(board)
		@board = board
  end


  def computer_turn
    # sleep(0.5)
    if @board.board[5] == SPACE
      return 5
    else
      find_computer_move
    end
  end

 def find_computer_move
    #I had inteded to break this out into 3 methods, however I was not sure how best to accomplish
    #this, since each method would need to return the position for the computer to win or block.
    #This would kick it back into the find_computer_move method, which would also require a return.
    #I am not sure if that would be easier to understand or not.
    @board.possible_wins.each do |line|
      if @board.times_in_line(line, "O") == 2
        return @board.empty_in_line(line) if @board.empty_in_line(line)
      end
    end
    @board.possible_wins.each do |line|
      if @board.times_in_line(line, "X") == 2
        return @board.empty_in_line(line) if @board.empty_in_line(line)
      end
    end
    @board.possible_wins.each do |line|
      if @board.times_in_line(line, "O") == 1
        return @board.empty_in_line(line) if @board.empty_in_line(line)
      end
    end
    @board.board.each do |key, value| 
      if value == SPACE 
        return key
      end
    end
  end
end