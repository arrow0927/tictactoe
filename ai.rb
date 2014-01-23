#!/usr/bin/ruby
class Ai
  
  require_relative 'player'
  attr_accessor :players
  
  
  
  def initialize(players)
    @players = players
    puts "AI is activated... for contest between #{@players[0].name} and #{@players[1].name}"
  end
  
  #After each move AI will update both players winning sequences
  def update_players_winning_sequences()
    @player[0].update_winning_sequences_tracker()
    @player[1].update_winning_sequences_tracker()
  end
  
end