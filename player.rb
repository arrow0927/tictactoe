#!/usr/bin/ruby
class Player
	require_relative 'dbmod'
	attr_accessor :name, :is_computer, :winning_sequences_tracker
#winning_sequences_tracker = {"rows"=>{0=>[[0, 0]], 1=>[], 2=>[]}, "cols"=>{0=>[[0, 0]], 1=>[], 2=>[]}}

	def initialize(name, is_computer)
	  #this hash keeps track of rows, column, digonals that the player is positioned on
		@winning_sequences_tracker = nil 
		@name = name
		@is_computer = is_computer
		
	end

end