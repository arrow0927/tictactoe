#!/usr/bin/ruby
	require_relative 'dbmod'
	require_relative "Player"
	require_relative "Board"
  require_relative "Ai"

class Game

	attr_accessor :current_player_index, :game_over, :players, :winner, :board, :curr_move, :ai

	def initialize(options)
		@board = Board.new()
		@players = Array.new()

		@players[0] = Player.new(options[:player1_name], false)
		if(options[:choice] == "player")
			@players[1] = Player.new(options[:player2_name], false)
		else
			@players[1] = Player.new("Computer", true)
			@ai = Ai.new(@players)
		end
		@current_player_index = 1
		@game_over = false
		@winner = false
		@curr_move = nil
	end


	def play_game()
		while(@game_over == false)
			@board.print_board(@players[0].name, @players[1].name)
			chosen_position = next_move() #Prompts player for position, checks input from player, returns it ----
			@board.update_board(chosen_position, @current_player_index ) #updates positions in board@board.
			update_player_moves_hash() #updates the winning_sequences_tracker variables within all players 
			@winner = there_is_a_winner()
			vacant_pos = num_vacant_positions_left() 
			puts "num_vacant_positions_left = #{vacant_pos}"
			if(@winner || ( vacant_pos == 0) )
				@game_over = true;
				if !@winner 
				  puts "\033[101m Game Over! \033[0m"
				  @board.print_board(@players[0].name, @players[1].name)
			  else
			    puts "\033[101m WINNER is #{@players[@winner].name}\033[0m"
			    @board.print_board(@players[0].name, @players[1].name)
        end
      end
		end
	end


	def next_move()
		choice_arr = nil
		#first find which player's turn it is
		@current_player_index == 0 ?  @current_player_index = 1 : @current_player_index = 0
		got_choice = false
    
    #this section if its the human's turn - ask human for choice
    #if(!@players[@current_player_index].is_computer)
		  while(!got_choice)
  			puts "#{@players[@current_player_index].name} your turn...."	
  			puts "enter the position. For example enter: 0,0"
  			choice_arr = STDIN.gets().chomp.split(",").map{|str| str.to_i}
  			#Check if its a valid position and if that position wasn't already taken----
  			if(@board.is_legalpos(choice_arr)) 
  				got_choice = true
  			end
  		end
		#else #this section if its the computer's turn - ai decides choice
		#choice = ai.get_optimal_position()
		#end
		#@ai.update_players_winning_sequences()
		choice_arr
	end

	# This method tells us how many positions are occupied by a player in any given row, in any given column, in any given digonal
	# When 3 positions are occupied it means that the entire row is occupied by this player and he is the winner
  # p0_rows = [3, 0, 0] --> player 0 is winner because row[0] has 3 positions occupied
  #   p0_cols = [1, 1, 1]
  #   p1_rows = [0, 0, 2]
  #   p1_cols = [0, 1, 1]
	def there_is_a_winner()
		#puts "Inside method to check if there is a winner"
		winner = false
		
		p0_rows = get_row_occupancy_numbers(0)
		p0_cols = get_col_occupancy_numbers(0)
		p1_rows = get_row_occupancy_numbers(1)
		p1_cols = get_col_occupancy_numbers(1)
    p0_ld = get_left_diag_occupancy_numbers(0)
    p0_rd = get_right_diag_occupancy_numbers(0)
    p1_ld = get_left_diag_occupancy_numbers(1)
    p1_rd = get_right_diag_occupancy_numbers(1)
    bs = @board.get_board_size()
		
		if (p0_rows.include?(bs) || p0_cols.include?(bs) || p0_ld.size() == bs || p0_rd.size() == bs )
			winner = 0
		elsif (p1_rows.include?(bs) || p1_cols.include?(bs) || p1_ld.size() == bs || p1_rd.size() == bs )
			winner = 1		  
	  else
	    puts "No winner found"
		end 
		winner
	end
	
	
	
def update_player_moves_hash
  puts "Updating player_moves_hash"
  keys = (0..@board.get_board_size()-1)
  p0_h = {"rows" => nil, "cols" => nil, "left_diag" => nil, "right_diag" => nil}
  p1_h = {"rows" => nil, "cols" => nil, "left_diag" => nil, "right_diag" => nil}
	p0_h["rows"] = Hash[keys.map {|pkey|[pkey, Array.new() ] }]
	p0_h["cols"] = Hash[keys.map {|pkey|[pkey, Array.new() ] }]
	p0_h["left_diag"] = Hash[@board.left_diag_positions_array.map {|pkey|[pkey, nil ] }]
  p0_h["right_diag"] = Hash[@board.right_diag_positions_array.map {|pkey|[pkey, nil ] }]

	p1_h["rows"] = Hash[keys.map {|pkey|[pkey, Array.new() ] }]
	p1_h["cols"] = Hash[keys.map {|pkey|[pkey, Array.new() ] }]
  p1_h["left_diag"] = Hash[@board.left_diag_positions_array.map {|pkey|[pkey, nil ] }]
  p1_h["right_diag"] = Hash[@board.right_diag_positions_array.map {|pkey|[pkey, nil ] }]
	
	@board.pos_hash.keys.each do |pos|
		#print "position = #{pos}\t"
		player_index = @board.pos_hash[pos]["belongs_to"]
		case player_index
		when 0
		  #print "belongs to #{@players[0].name}\n"
			p0_h["rows"][pos[0]] << pos
			p0_h["cols"][pos[1]] << pos
			if(p0_h["left_diag"].has_key?(pos)) 
			  p0_h["left_diag"][pos] = 1
		  end
		  if(p0_h["right_diag"].has_key?(pos)) 
			  p0_h["right_diag"][pos] = 1
		  end
		when 1
		  #print "belongs to #{@players[1].name}\n"
			p1_h["rows"][pos[0]] << pos
			p1_h["cols"][pos[1]] << pos
      if(p1_h["left_diag"].has_key?(pos)) 
			  p1_h["left_diag"][pos] = 1
		  end
		  if(p1_h["right_diag"].has_key?(pos)) 
			  p1_h["right_diag"][pos] = 1
		  end		  
		else
			#puts "Board position is vacant"
		end
	end
	@players[0].winning_sequences_tracker = p0_h 
	@players[1].winning_sequences_tracker = p1_h
	#puts "#{@players[0].name}'s winning_sequences_tracker = #{@players[0].winning_sequences_tracker}"
	#puts "#{@players[1].name}'s winning_sequences_tracker = #{@players[1].winning_sequences_tracker}"
end

# def initialize_winning_moves
#     wm = [
#       [[0,0],[0,1], [0,2]],
#       [[1,0],[1,1], [1,2]],
#       [[2,0],[2,1], [2,2]],
#       [[0,0],[1,0], [2,0]],
#       [[0,1],[1,1], [2,1]],
#       [[0,2],[1,2], [2,2]],
#       [[0,0],[1,1], [2,2]],
#       [[0,2],[1,1], [2,0]],
#       ]
#     puts "Initialized winning moves = #{wm.inspect}"
#     wm
#   end
	
  # ash's winning_sequences_tracker = {"rows"=>{0=>[[0, 0], [0, 1], [0, 2]], 1=>[], 2=>[]}, "cols"=>{0=>[[0, 0]], 1=>[[0, 1]], 2=>[[0, 2]]}}
  # punya's winning_sequences_tracker = {"rows"=>{0=>[], 1=>[], 2=>[[2, 1], [2, 2]]}, "cols"=>{0=>[], 1=>[[2, 1]], 2=>[[2, 2]]}}
  
  def get_row_occupancy_numbers(player_index)
    row_occupancy = Array.new()
    @players[player_index].winning_sequences_tracker["rows"].keys.each do |row|
      #puts "#{@players[player_index].name} is occupying #{@players[player_index].winning_sequences_tracker["rows"][row].size} spots in row #{row}"
      row_occupancy[row] = @players[player_index].winning_sequences_tracker["rows"][row].size
    end
    row_occupancy
  end 	

  def get_col_occupancy_numbers(player_index)
    col_occupancy = Array.new()
    @players[player_index].winning_sequences_tracker["cols"].keys.each do |col|
      #puts "#{@players[player_index].name} is occupying #{@players[player_index].winning_sequences_tracker["cols"][col].size} spots in col #{col}"
      col_occupancy[col] = @players[player_index].winning_sequences_tracker["cols"][col].size
    end
    col_occupancy
	end
	
	def get_left_diag_occupancy_numbers(player_index)
	 left_diag_occupancy = Array.new()
   @players[player_index].winning_sequences_tracker["left_diag"].keys.each do |key|
     if(@players[player_index].winning_sequences_tracker["left_diag"][key] == 1)
       left_diag_occupancy << key
       #puts "inside get_left_diag_occupancy_numbers() added #{key.inspect} to left_diag_occupancy to make it #{left_diag_occupancy.inspect}"
     end
   end
   #puts "#{@players[player_index].name} is occupying #{left_diag_occupancy.size} spots in left diagonal"
    left_diag_occupancy
  end
  
  def get_right_diag_occupancy_numbers(player_index)
	  right_diag_occupancy = Array.new()
     @players[player_index].winning_sequences_tracker["right_diag"].keys.each do |key|
       if(@players[player_index].winning_sequences_tracker["right_diag"][key] == 1)
         right_diag_occupancy << key
       end
     end
      #puts "#{@players[player_index].name} is occupying #{right_diag_occupancy.size} spots in right diagonal"
      right_diag_occupancy
  end
  
  #@players[player_index].winning_sequences_tracker = {"rows"=>{0=>[[0, 0]], 1=>[], 2=>[]}, "cols"=>{0=>[[0, 0]], 1=>[], 2=>[]}, 
  #"left_diag"=>{[0, 0]=>1, [1, 1]=>nil, [2, 2]=>nil}, "right_diag"=>{[2, 0]=>nil, [1, 1]=>nil, [0, 2]=>nil}}
  
  #ash's winning_sequences_tracker = {"rows"=>{0=>[[0, 0]], 1=>[], 2=>[]}, "cols"=>{0=>[[0, 0]], 1=>[], 2=>[]}}
   #tom's winning_sequences_tracker = {"rows"=>{0=>[], 1=>[], 2=>[[2, 2]]}, "cols"=>{0=>[], 1=>[], 2=>[[2, 2]]}}
   # unique_positions for player ash = [[0, 0]]
   #   unique_positions for player ash = [[0, 0]]
   #   unique_positions for player tom = [[2, 2]]
   #   unique_positions for player tom = [[2, 2]]
  
  def get_all_positions_occupied_by_player(player_index)
    unique_positions = Array.new()
   # puts "@players[player_index].winning_sequences_tracker = #{@players[player_index].winning_sequences_tracker}"
   @players[player_index].winning_sequences_tracker.keys.each do |key|
     #print "\nouter key = #{key}\n"
      if(key=="left_diag")
        unique_positions = unique_positions | get_left_diag_occupancy_numbers(player_index)
      elsif(key=="right_diag")
        unique_positions = unique_positions | get_right_diag_occupancy_numbers(player_index)
      else
        @players[player_index].winning_sequences_tracker[key].keys.each do |el|
          #print "\tinner key = #{el}"
          #puts "concatenating #{unique_positions.inspect} and \n #{@players[player_index].winning_sequences_tracker[key][el].inspect}"
          unique_positions = unique_positions | @players[player_index].winning_sequences_tracker[key][el]
          #print "\tunique positions = #{unique_positions}"
        end #inner loop
     end #if/else
   end #outer loop
    puts "outside loop unique_positions for player #{@players[player_index].name} = #{unique_positions.inspect}"
    puts "outside loop unique_positions size for player #{@players[player_index].name} = #{unique_positions.size}"
    unique_positions
  end
  
 
  
  def num_vacant_positions_left()
    p0 = get_all_positions_occupied_by_player(0).size()
    p1 = get_all_positions_occupied_by_player(1).size()
    tot = @board.get_total_positions_on_Board()
    puts "All positions occupied by player #{@players[0].name} are #{p0.inspect}"
    puts "All positions occupied by player #{@players[1].name} are #{p1.inspect}"
    puts "Total board positions are #{tot}"
    
    tot - ( p0 +  p1)
  end

	def stop_game()
		puts "Stop game invoked"
		exit
	end

	
	

end