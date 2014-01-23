#!/usr/bin/ruby
class Player
	require_relative 'dbmod'
	attr_accessor :moves, :name, :color, :is_computer

	def initialize(name, is_computer)
		@moves = Array.new() 
		@winning_sequences_tracker = Hash.new() #tracks the moves and size of winning sequences
		@name = name
		@is_computer = is_computer
		@color = color
	end

  # If a row/col/diagonal has 1 or more positions for this player it is a winning sequence
  # The number of sibilings in a given row is the rank of the winning sequence
  def update_winning_sequences_tracker()
  
  end
end