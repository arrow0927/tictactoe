#!/usr/bin/ruby
class Ai
  
  require_relative 'player'
  require_relative 'game'
  attr_accessor :players, :game
  
  
  
  def initialize(players, game)
    @players = players
    @game = game
    puts "AI.game instance_of #{@game.instance_of?(Game)}"
    puts "AI.game kind_of #{@game.kind_of?(Game)}"
    puts "AI is activated... for contest between #{@players[0].name} and #{@players[1].name}"
  end
  
 def get_optimal_position()
   # Look at opponents positions
   
   # Find how many moves before he wins for every given position
   
   # Pick that position with the least amount of moves for him to win
   
   #Compare that position to the position that has 
   
   
 end
  
end