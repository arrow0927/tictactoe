#!/usr/bin/ruby
class Player
	require_relative 'dbmod'
	attr_accessor :name, :color, :is_computer, :winning_sequences_tracker

	def initialize(name, is_computer)
		@winning_sequences_tracker = nil #tracks the moves and size of winning sequences
		@name = name
		@is_computer = is_computer
		@color = color
		
	end

  # If a row/col/diagonal has 1 or more positions for this player it is a winning sequence
  # The number of sibilings positions in a given row is the rank of the winning sequence
  def update_winning_sequences_tracker()
  
  end
end