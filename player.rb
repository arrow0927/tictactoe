#!/usr/bin/ruby
class Player
	require_relative 'dbmod'
	attr_accessor :moves, :name, :color

	def initialize(name)
		@moves = Array.new()
		@name = name
		@color = color
	end

end