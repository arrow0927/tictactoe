#!/usr/bin/ruby
	require_relative 'dbmod'
	require_relative "Player"
	require_relative "Board"
  require_relative "ai"

class Game

	attr_accessor :current_player_index, :game_over, :players, :winner, :board, :curr_move, :win_moves, :ai

	def initialize(options)
		@board = Board.new()
		@win_moves = initialize_winning_moves
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
			update_player_moves_arrays()
=begin
			@winner = there_is_a_winner()
			puts "winner = #{@winner}"
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
		puts "Inside method to check if there is a winner, updated player_moves_arrays"
		puts "@players[0].moves = #{@players[0].moves.inspect}"
		puts "@players[1].moves = #{@players[1].moves.inspect}"
		winner = false
		#If either player have played less than 3 rounds they cannot win
		if (@players[0].moves.size < 3 && @players[1].moves.size < 3)
			puts "Inside method to check if there is a winner, no winner found"
			return winner
		else
			@win_moves.each_with_index do |arr, index|
				puts "@win_moves[#{index}]=#{arr}"
				matchp0 = 0
				matchp1 = 0
				arr.each do|el|
					if(@players[0].moves.include?(el))
						matchp0 = matchp0 + 1
					end 
					if(@players[1].moves.include?(el))
						matchp1 = matchp1 + 1
					end 
			end
		puts "matchp0 = #{matchp0}"
		puts "matchp1 = #{matchp1}"
		if(matchp0 == 3) 
			winner = 0
		end
		if(matchp1 == 3) 
			winner = 1
		end

		return winner
	end 





		end
	end
	
def update_player_moves_arrays
  puts "Updating player_moves_arrays"
	player0_arr = Array.new()
	player1_arr = Array.new()
	@board.pos_hash.keys.each do |pos|
		print "position = #{pos}\t"
		player_index = @board.pos_hash[pos]["belongs_to"]
		case player_index
		when 0
		  print "belongs to #{@players[0].name}\n"
			player0_arr << pos
			
		when 1
		  print "belongs to #{@players[1].name}\n"
			player1_arr << pos
		else
			puts "Board position is vacant"
		end
	end
	@players[0].moves = player0_arr 
	@players[1].moves = player1_arr
	puts "#{@players[0].name}'s moves array = #{@players[0].moves}"
	puts "#{@players[1].name}'s moves array = #{@players[1].moves}"
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
	


	

	def stop_game()
		puts "Stop game invoked"
		exit
	end

	
	

end