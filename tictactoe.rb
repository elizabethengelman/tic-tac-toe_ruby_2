class TicTacToe
  def initialize
  	@board = [" "," ", " ", " ", " ", " ", " ", " ", " "]
    @turn = :human
    @turn_counter = 1
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
    @turn = :computer
    @turn_counter += 1
    puts "this is the turn counter #{@turn_counter}"
    update_board
    
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
      @position = @board.find_index(" ")
    end
    @turn_counter += 1
    puts "this is the thurn counter #{@turn_counter}"
    update_board
  end

  def update_board
    @board[@position] = @mark
    print_board
    start_game
  end

end


my_board = TicTacToe.new
puts my_board.print_board
my_board.start_game


