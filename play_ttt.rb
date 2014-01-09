require_relative 'lib/game'
require_relative 'lib/board'
require_relative 'lib/user_interface'
require_relative 'lib/play'

user = UserInterface.new
game = Game.new(user)
new_play = Play.new(user, game)
new_play.start_playing