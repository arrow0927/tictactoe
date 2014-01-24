
class Board
	attr_accessor  :pos_hash, :left_diag_positions_array, :right_diag_positions_array
	BOARD_SIZE = 3
	

def initialize()
	@pos_hash = initialize_position_hash
  @left_diag_positions_array = get_left_diagonal_positions()
  @right_diag_positions_array = get_right_diagonal_positions()
end

def get_board_size()
  BOARD_SIZE
end

def get_left_diagonal_positions
  left_diag_positions = Array.new()
  (0..BOARD_SIZE - 1).each do |i|
    left_diag_positions << [ i , i ]
  end
  left_diag_positions
end

def get_right_diagonal_positions
  right_diag_positions = Array.new()
  limit = get_board_size() -1
  (0..limit).each do |i|
    right_diag_positions << [ limit - i  , i ]
  end
  right_diag_positions
end 

	def update_board(choicen_position , current_player_index)
		#Add choice to positions hash	
		#puts "@pos_hash before update = #{@pos_hash.inspect }"
		puts "Chosen position = #{choicen_position.inspect}"
		@pos_hash[choicen_position]["belongs_to"] = current_player_index
		#puts "@pos_hash after update = #{@pos_hash.inspect }"
	end

#belongs_to points to the value of the index in the @players array in Game
	def initialize_position_hash
		rows = (0..BOARD_SIZE-1).to_a
		cols = (0..BOARD_SIZE-1).to_a
		pos_keys = rows.product(cols) #[[0, 0], [0, 1], [0, 2], [1, 0], [1, 1], [1, 2], [2, 0], [2, 1], [2, 2]]
    pos_keys_hash = Hash[pos_keys.map {|pkey|[pkey, Hash["belongs_to" => nil] ] }]
		puts "Initialized Board Positions: #{pos_keys_hash.inspect}"
		pos_keys_hash
	end

	

	def print_board(player0Name, player1Name)
		puts "*" * 60
		print "\t \033[31m#{player0Name} is red\033[0m \t\t"
		print "\033[34m#{player1Name} is blue\033[0m \n"
		puts "*" * 60
		(0..2).each do |row|
	     print_row(row)
	  end
		puts ""
		puts "*" * 60
		puts ""
	end
	
  def print_row(row)
		(0..2).each do |col|
			pos_arr = [row,col]
			#puts "pos_arr = #{pos_arr}"
			cp = colored_position(pos_arr)
			print "\t"
			print cp
			print "\t"
		end	
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

	


	def get_total_positions_on_Board()
    BOARD_SIZE * BOARD_SIZE
	end

	def is_legalpos(postion_arr)
		legal = false
	  if(!postion_arr.kind_of?(Array) && postion_arr.size > 2)
		    puts "pos_array = #{pos_array} is not array or too long"
    else    
			#first make sure that 
			@pos_hash.keys.each do|key|	
				if(key == postion_arr) #the choice has to be a legal position 
					if( (@pos_hash[key]["belongs_to"]).nil? ) # and it has to be available
						legal = true
					end
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