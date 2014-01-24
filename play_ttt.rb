require_relative 'lib/game'
require_relative 'lib/board'
require_relative 'lib/user_interface'
require_relative 'lib/game_loop'
require_relative 'lib/computer'
require_relative 'lib/user'


user_interface = UserInterface.new
game = Game.new(user_interface)
play_the_game = GameLoop.new(user_interface, game)
play_the_game.start_playing