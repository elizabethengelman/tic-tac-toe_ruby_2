class Computer
  SPACE = " "
  
	def initialize(board, user_interface)
		@board = board
    @user_interface = user_interface
  end

  def player_turn
    @user_interface.print_out("The computer is playing...")
    if @board.board[5] == SPACE
      position = 5
    else
      position = find_computer_move
    end
    [position, "O"]
  end

  def three_in_a_row_possible?(line)
    @board.times_in_line(line, "O") == 2 && @board.empty_in_line(line)
  end

  def block_opponent_possible?(line)
    @board.times_in_line(line, "X") == 2 && @board.empty_in_line(line)
  end

  def find_computer_move
    @board.possible_wins.each do |line|
      if three_in_a_row_possible?(line)
        return @board.empty_in_line(line)
      end
    end
    @board.possible_wins.each do |line|
      if block_opponent_possible?(line)
        return @board.empty_in_line(line)
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