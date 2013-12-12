class TicTacToe
  def initialize
    @turn = :human
    @turn_counter = 1
    @possible_wins = [ [1, 2, 3], 
                       [4, 5, 6], 
                       [7, 8, 9], 
                       [1, 4, 7],
                       [2, 5, 8],
                       [3, 6, 9],
                       [1, 5, 9],
                       [3, 5, 7] 
                     ]  
  end
  
  def play_new_game
    @board = {1 => " ", 2 => " ", 3 => " ", 4 => " ", 5 => " ", 6 => " ", 7 => " ", 8 => " ", 9 => " "}
    @turn_counter = 1
    print_board
    play_game
  end

  def print_board
    puts "#{@board[1]} | #{@board[2]} | #{@board[3]}"
    puts "_________"
    puts "#{@board[4]} | #{@board[5]} | #{@board[6]}"
    puts "_________"
    puts "#{@board[7]} | #{@board[8]} | #{@board[9]}"
  end

  def play_game
    until @turn_counter == 10
      game_check
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
  	  if @board[5] == " "
  	  	@position = 5
       else
       	@position = 3
       end
    else
      @position = find_computer_move
    end
    @turn_counter += 1
    update_board
  end

  def find_computer_move
  	@possible_wins.each do |line|
  	  if times_in_line(line, "O") == 2
  	  	computer_move = empty_in_line(line)
        if computer_move
          return computer_move
        end
  	  end
  	end

  	@possible_wins.each do |line|
  	  if times_in_line(line, "X") == 2
  	  	computer_move = empty_in_line(line)
        if computer_move
          return computer_move
        end
  	  end
    end

    @possible_wins.each do |line|
      if times_in_line(line, "O") == 1
        computer_move = empty_in_line(line)
        if computer_move
          return computer_move
        end
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
    play_game
  end

  def times_in_line(poss_winning_line, player_mark)
    times = 0
    poss_winning_line.each do |index|
      times += 1 if @board[index] == player_mark
      unless @board[index] == player_mark || @board[index] == " "
        return 0
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

  def valid_move?(index)
  	@board[index] == " "
  end

  def game_check
    @possible_wins.each do |line|
      if times_in_line(line, "X") == 3
        puts "Oops, it looks like you win!  That wasn't supposed to happen :|"
        start_new_game
      end
    end

    @possible_wins.each do |line|
      if times_in_line(line, "O") == 3
        puts "The computer wins!"
        start_new_game
      end
    end

    if @turn_counter == 9
      puts "You've tied!"
      start_new_game
    end
  end

  def start_new_game
    puts "Game over! Would you like to start a new game?"
    response = gets.chomp
    if response == "yes"
      play_new_game
    else
      abort("Thanks for playing!")
    end
  end
  
end

my_board = TicTacToe.new
my_board.play_new_game


