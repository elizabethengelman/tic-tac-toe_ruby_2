class TicTacToe
  def initialize
  	#originally had this as an array as well, and though i could change the value of elements of the board array, 
  	#i had trouble persisting that data into the possible_wins array, which is dependent on the @board array info - different object ids

  	@board = {0 => " ", 1 => " ", 2 => " ", 3 => " ", 4 => " ", 5 => " ", 6 => " ", 7 => " ", 8 => " "}
    @turn = :human
    @turn_counter = 1
    @possible_wins = [ [0, 1, 2], 
                       [3, 4, 5], 
                       [6, 7, 8], 
                       [0, 3, 6],
                       [1, 4, 7],
                       [2, 5, 8],
                       [0, 4, 8],
                       [2, 4, 6] 
                     ]  
  end

  def print_board
    puts "#{@board[0]} | #{@board[1]} | #{@board[2]}"
    puts "_________"
    puts "#{@board[3]} | #{@board[4]} | #{@board[5]}"
    puts "_________"
    puts "#{@board[6]} | #{@board[7]} | #{@board[8]}"
  end

  def start_game
    while @turn_counter < 10
      if @turn == :human
        player_turn
      else 
        computer_turn
      end
    end
  end

  def player_turn
    puts "Where would you like to place your X?"
    @position = gets.chomp.to_i
    @mark = "X"
    if valid_move?(@position)
      @turn = :computer
      @turn_counter += 1
      puts "this is the turn counter #{@turn_counter}"
      update_board
    else
      puts "Sorry, that is not a valid move, please try again."
    end
  end

   
  
  def computer_turn
  	puts "The computer is playing!"
  	@turn = :human
  	@mark = "O"
  	if @turn_counter == 2
  	  if @board[4] == " "
  	  	@position = 4
       else
       	@position = 2
       end
    else
      @position = find_computer_move
      p "The computer's next move is #{@position}"
    end
    @turn_counter += 1
    puts "this is the thurn counter #{@turn_counter}"
    update_board
  end


  def find_computer_move
  	# first, check to see if there is move where the computer would win
  	@possible_wins.each do |line|
  	  if times_in_line(line, "O") == 2
  	  	return empty_in_line(line)
  	  end
  	end

  	#if there is not, check to see if there is a move to block the opponent
  	@possible_wins.each do |line|
  	  if times_in_line(line, "X") == 2 && line.include?(" ")
  	  	return empty_in_line(line)
  	  end
    end

    @possible_wins.each do |line|
      if times_in_line(line, "O") == 1
        return empty_in_line(line)
      end
    end
    
    @board.each do |key, value|
      if value == " "
        return key
      end
    end
  end
  
  def update_board
    @board[@position] = @mark
    print_board
    start_game
  end


  def times_in_line(poss_winning_line, player_mark)
    times = 0
    poss_winning_line.each do |index|
      if @board[index] == player_mark
      	times += 1
      	unless @board[index] == player_mark || @board[index] = " "
      	  return 0
      	end
      end
    end
    times  
  end

  def empty_in_line(poss_winning_line)
  	poss_winning_line.each do |index|
  	  if @board[index] == " "
  	  	return index
  	  end
  	end
  end


  #checked after changing @board to an array
  def valid_move?(index)
  	@board[index] == " "
  end
  
end


my_board = TicTacToe.new
puts my_board.print_board
my_board.start_game
# p my_board.find_computer_move


