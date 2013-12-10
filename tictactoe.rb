class Board
  def initialize
  	@board = [" "," ", " ", " ", " ", " ", " ", " ", " "]
    @turn = :human
  end

  def print_board
    puts "#{@board[0]} | #{@board[1]} | #{@board[2]}"
    puts "_________"
    puts "#{@board[3]} | #{@board[4]} | #{@board[5]}"
    puts "_________"
    puts "#{@board[6]} | #{@board[7]} | #{@board[8]}"
  end

 def start_game
   puts "Welcome to tic-tac-toe! You're X's, let's get started!"
   9.times do 
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
   update_board
 end

 def computer_turn
 	puts "The computer is playing!"
 	@turn = :human
 end

 def update_board
   @board[@position] = @mark
   print_board
   start_game
 end



end


my_board = Board.new
puts my_board.print_board
my_board.start_game


