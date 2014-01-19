
class Board
	attr_accessor  :pos_hash
	
	

def initialize()
	@pos_hash = initialize_position_hash
# @pos_hash{"a1"=>{"belongs_to"=>nil}, "a2"=>{"belongs_to"=>nil} }
end


	def update_board(choicen_position , current_player_index)
		#Add choice to positions hash	
		#puts "@pos_hash before update = #{@pos_hash.inspect }"
		@pos_hash[choicen_position]["belongs_to"] = current_player_index
		#puts "@pos_hash after update = #{@pos_hash.inspect }"
	end

#belongs_to points to the value of the index in the @players array in Game
	def initialize_position_hash
		keys = ["a1", "a2", "a3", "b1", "b2", "b3", "c1", "c2", "c3"]
		ph = Hash[keys.map {|key|[key, Hash["belongs_to" => nil] ] }]
		puts "Initialized Board Positions: #{ph.inspect}"
		ph
	end

	

	def print_board(player0Name, player1Name)
		puts "*" * 60
		print "\t \033[31m#{player0Name} is red\033[0m \t\t"
		print "\033[34m#{player1Name} is blue\033[0m \n"
		puts "*" * 60
		('a'..'c').each do |row|
			print_row(row)
		end
		puts ""
		puts "*" * 60
		puts ""
	end

	
	def colored_position(position)
		colored_pos = nil
		if( @pos_hash[position]["belongs_to"] == 0)		#if position belongs to player[0] it will be colored red
			colored_pos = "\033[31m#{position}\033[0m"
		elsif ( @pos_hash[position]["belongs_to"] == 1)#if position belongs to player[1]] it will be colored blue
			colored_pos = "\033[34m#{position}\033[0m"
		else		#if position is empty it will be in green
			colored_pos = position
		end
	colored_pos		
	end

	def print_row(row)
		#rows = a, b, c
		#cols = 1, 2, 3
		(1..3).each do |col|
			pos = "#{row}#{col.to_s}"
			cp = colored_position(pos)
			print "\t"
			print cp
			print "\t"
		end	
		puts ""
	end


	def any_vacant_positions_left()
		vacancies = false
		@pos_hash.keys.each do |key|
			if(@pos_hash[key]["belongs_to"].nil?)
				vacancies = true
			end
		end
		vacancies
	end

	def is_legalpos(postion)
		legal = false
			#first make sure that 
			@pos_hash.keys.each do|key|	
				if(key.casecmp(postion) == 0) #the choice has to be a legal position 
					if( (@pos_hash[key]["belongs_to"]).nil? ) # and it has to be available
						legal = true
					end
				end
			end
		if (legal) 
			puts "\t\tyour move was legal"
		else
			puts "\t\tyour move was illegal, try again"
		end
		legal
	end

end