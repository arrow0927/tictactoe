class Board
    require_relative 'position'
    
	attr_accessor  :pos_array, :left_diag_positions_array, :right_diag_positions_array, :total_positions, :occupied_positions
	unless (const_defined?(:BOARDSIZE))
      BOARDSIZE = 3
    end
	

def initialize()
	@pos_array = initialize_pos_array()
	@total_positions = BOARDSIZE * BOARDSIZE
	@occupied_positions = 0
	#print_position_array()
end

def print_board(player0Name, player1Name)
	puts "*" * 120
	print "\t \033[31m#{player0Name} is red\033[0m \t\t"
	print "\033[34m#{player1Name} is blue\033[0m \n"
	puts "*" * 120
	(0..BOARDSIZE - 1).each do |row|
     print_row(row)
  end
	puts ""
	puts "*" * 120
	puts ""
end

def boardsize()
  BOARDSIZE
end

def print_ranks()
  (0..BOARDSIZE - 1).each do |row|
    (0..BOARDSIZE - 1).each do |col|
      print "Position = #{@pos_array[row][col].coordinates}>>"
      print "player[0] rank= #{(@pos_array[row][col]).rank0}\t"
      print "player[1] rank = #{(@pos_array[row][col]).rank1}\n"
    end
  end
end

#choicen_position = [0,0]
	def update_board(choicen_position , current_player_index)
		@pos_array[choicen_position[0]][choicen_position[1]].belongs_to = current_player_index
		@pos_array[choicen_position[0]][choicen_position[1]].rank0 = 0
		@pos_array[choicen_position[0]][choicen_position[1]].rank1 = 0		
		@occupied_positions += 1
		puts "Board updated...\n[#{choicen_position[0]}] [#{choicen_position[1]}] belongs_to  #{@pos_array[choicen_position[0]][choicen_position[1]].belongs_to}"
		puts "Board updated...\n[#{choicen_position[0]}] [#{choicen_position[1]}] rank0  #{@pos_array[choicen_position[0]][choicen_position[1]].rank0}"
		puts "Board updated...\n[#{choicen_position[0]}] [#{choicen_position[1]}] rank1  #{@pos_array[choicen_position[0]][choicen_position[1]].rank1}"
	end


	def is_legalpos(choice_arr)
	  #puts "Evaluating choice #{choice_arr} to see if its legal....."
		legal = false
	  if(!choice_arr.kind_of?(Array) && choice_arr.size > 2)
		    puts "INPUT TO  is_legalpos IS INVALID = #{pos_array} >> not array or too long"
    else    
			#first make sure that 
			  @pos_array.each do|row|
  			    row.each do|pos_obj|	
    				  if(choice_arr == pos_obj.coordinates)
    				      #puts "Choice is in the right format.....checking if its valid position"
      					  if( pos_obj.belongs_to.nil? ) # and it has to be available
        						legal = true
        					end
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
	#=================================================================================
	private
	
	#belongs_to points to the value of the index in the @players array in Game
  	def initialize_pos_array
  		parr = Array.new(BOARDSIZE)
  		(0..BOARDSIZE - 1).each do |row|
  		  parr[row] = Array.new(BOARDSIZE)
  		  (0..BOARDSIZE - 1).each do |col|
  		    parr[row][col] = Position.new([row,col])
  		    #puts "Adding position to (#{parr[row][col]}) = #{(parr[row][col]).inspect}"
  		  end
		  end
		  #puts "#{parr.inspect}"
      parr
  	end

    def print_position_array()
            (0..BOARDSIZE - 1).each do |row|
              (0..BOARDSIZE - 1).each do |col|
                print "@pos_array[#{row.to_i}][#{col.to_i}] = #{@pos_array[row][col]}"
              end
              puts "============================end of row #{row}============================="
            end
        end


	  def colored_position(position)
  		colored_pos = nil
  		if( position.belongs_to == 0)		#if position belongs to player[0] it will be colored red
  			colored_pos = "\033[31m#{position.coordinates}r0=#{position.rank0},r1=#{position.rank1}\033[0m"
  		elsif ( position.belongs_to == 1)#if position belongs to player[1]] it will be colored blue
  			colored_pos = "\033[34m#{position.coordinates}r0=#{position.rank0},r1=#{position.rank1}\033[0m"
  		else		#if position is empty it will be in green
  			colored_pos = "#{position.coordinates}r0=#{position.rank0},r1=#{position.rank1}"
  		end
  	colored_pos		
  	end
	
	  def print_row(row)
  		(0..BOARDSIZE - 1).each do |col|
  			cp = colored_position(pos_array[row][col])
  			print "\t"
  			print cp
  			print "\t\t"
  		end	
  		puts ""
  	end
	
	
end