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
			update_player_moves_hash()
			

			@winner = there_is_a_winner()
			puts "winner = #{@winner}"
=begin
			if(@winner || ! @board.any_vacant_positions_left() )
				puts "\033[101mWINNER!!!!\033[0m"
				puts "There was a winner, winner is  #{@players[@winner].name}\ngame over!"
        @board.print_board(@players[0].name, @players[1].name)
				@game_over = true;
			end
=end
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

	

	def there_is_a_winner()
		puts "Inside method to check if there is a winner"
		winner = false
		#If either player have played less than 3 rounds they cannot win
		player0_rows_occupied = get_row_occupancy_numbers(0)
		player0_cols_occupied = get_col_occupancy_numbers(0)
		player1_rows_occupied = get_row_occupancy_numbers(1)
		player1_cols_occupied = get_col_occupancy_numbers(1)
    # player0_leftdiag_occupied = 
    # player0_rightdiag_occupied = 
    # player1_leftdiag_occupied = 
    # player1_rightdiag_occupied =
		puts "player0_rows_occupied = #{player0_rows_occupied}"
		puts "player0_cols_occupied = #{player0_cols_occupied}"
		puts "player1_rows_occupied = #{player1_rows_occupied}"
		puts "player1_cols_occupied = #{player1_cols_occupied}"
		
		if (player0_rows_occupied.include?(@board.get_board_size()) || player0_cols_occupied.include?(@board.get_board_size()) )#|| player0_leftdiag_occupied ==3 || player0_rightdiag_occupied == 3)
			winner = 0
		elsif (player1_rows_occupied.include?(@board.get_board_size()) || player1_cols_occupied.include?(@board.get_board_size()))#|| player1_leftdiag_occupied ==3 || player1_rightdiag_occupied == 3)
			winner = 1		  
	  else
	    puts "No winner found"
		end 
		winner
	end
	
def update_player_moves_hash
  puts "Updating player_moves_hash"
  keys = (0..@board.get_board_size()-1)
  player0_hash = {"rows" => nil, "cols" => nil}
  player1_hash = {"rows" => nil, "cols" => nil}
	player0_hash["rows"] = Hash[keys.map {|pkey|[pkey, Array.new() ] }]
	player0_hash["cols"] = Hash[keys.map {|pkey|[pkey, Array.new() ] }]
	player1_hash["rows"] = Hash[keys.map {|pkey|[pkey, Array.new() ] }]
	player1_hash["cols"] = Hash[keys.map {|pkey|[pkey, Array.new() ] }]
	
	@board.pos_hash.keys.each do |pos|
		print "position = #{pos}\t"
		player_index = @board.pos_hash[pos]["belongs_to"]
		case player_index
		when 0
		  print "belongs to #{@players[0].name}\n"
			player0_hash["rows"][pos[0]] << pos
			player0_hash["cols"][pos[1]] << pos
		when 1
		  print "belongs to #{@players[1].name}\n"
			player1_hash["rows"][pos[0]] << pos
			player1_hash["cols"][pos[1]] << pos
		else
			puts "Board position is vacant"
		end
	end
	@players[0].winning_sequences_tracker = player0_hash 
	@players[1].winning_sequences_tracker = player1_hash
	puts "#{@players[0].name}'s winning_sequences_tracker = #{@players[0].winning_sequences_tracker}"
	puts "#{@players[1].name}'s winning_sequences_tracker = #{@players[1].winning_sequences_tracker}"
end

def initialize_winning_moves
		wm = [
			[[0,0],[0,1], [0,2]],
			[[1,0],[1,1], [1,2]],
			[[2,0],[2,1], [2,2]],
			[[0,0],[1,0], [2,0]],
			[[0,1],[1,1], [2,1]],
			[[0,2],[1,2], [2,2]],
			[[0,0],[1,1], [2,2]],
			[[0,2],[1,1], [2,0]],
			]
		puts "Initialized winning moves = #{wm.inspect}"
		wm
	end

  def get_row_occupancy_numbers(player_index)
    row_occupancy = Array.new()
    @players[player_index].winning_sequences_tracker["rows"].keys.each do |row|
      puts "#{@players[player_index].name} is occupying #{@players[player_index].winning_sequences_tracker["rows"][row].size} spots in row #{row}"
      row_occupancy[row] = @players[player_index].winning_sequences_tracker["rows"][row].size
    end
    row_occupancy
  end 	

  def get_col_occupancy_numbers(player_index)
    col_occupancy = Array.new()
    @players[player_index].winning_sequences_tracker["cols"].keys.each do |col|
      puts "#{@players[player_index].name} is occupying #{@players[player_index].winning_sequences_tracker["cols"][col].size} spots in col #{col}"
      col_occupancy[col] = @players[player_index].winning_sequences_tracker["cols"][col].size
    end
    col_occupancy
	end
	
	def get_diag_occupancy_numbers(player_index)
	  
  end

	def stop_game()
		puts "Stop game invoked"
		exit
	end

	
	

end