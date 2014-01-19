#!/usr/bin/ruby
=begin
Tic Tac Toe Game
The player can choose to play the game between 2 people or between a player and a computer
Variables:
Game Mode
board_state
=end
require_relative "dbmod"
require_relative "Game"
require_relative "Player"
require_relative "Board"
include Dbmod
#Get user info to configure game
puts <<PARA
Hello. My name is Ash I created this game...
If you wish to play with another player  enter 1
If you wish to play with the computer enter 2

Make your choice now....
PARA

options = Hash.new()
chosen = STDIN.gets().chomp
puts "chosen = #{chosen}"
if chosen.to_i == 1
	options[:choice] = "player"	
elsif chosen.to_i == 2
	options[:choice] = "Computer"	
else 
	puts "Bad choice #{options[:mode]}... exiting"
	exit
end
puts "your opponent will be a #{options[:choice]}"

puts <<PARA2
	Please enter first players name  ...
PARA2
options[:player1_name] = STDIN.gets().chomp

if(options[:choice] == "player")
puts <<PARA3
	Please enter second players name  ...
PARA3
	options[:player2_name] = STDIN.gets().chomp
end
g = Game.new(options)
#Dbmod::print_game_state(g)

g.play_game()


