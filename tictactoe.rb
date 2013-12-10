class Board
  def initialize
  	@board = [" "," ", " ", " ", " ", " ", " ", " ", " "]
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
   player_turn
 end

 def player_turn
   puts "Where would you like to place your X?"
   @position = gets.chomp.to_i
   @mark = "X"
   change_board
 end

 def change_board
   @board[@position] = @mark
   print_board
   start_game
 end


end


my_board = Board.new
puts my_board.print_board
my_board.start_game


