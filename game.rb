#!/usr/bin/ruby
	
	require_relative "Player"
	require_relative "Board"
  require_relative "Ai"

class Game

	attr_accessor :current_player_index, :game_over, :players, :winner, :board, :curr_move, :ai

	def initialize(options)
		@board = Board.new()
		@players = Array.new()
    @ai = Ai.new(@players, self, @board) # send a copy of game object to ai
		@players[0] = Player.new(options[:player1_name], false)
		if(options[:choice] == "player")
			@players[1] = Player.new(options[:player2_name], false)
		else
			@players[1] = Player.new("Computer", true)
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
			@board.update_board(chosen_position, @current_player_index ) #[0,0] -> chosen position
			@winner = get_winner_and_update_ranks()
			vacant_pos = num_vacant_positions_left() 
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



  def num_vacant_positions_left()
    @board.total_positions - @board.occupied_positions
  end



#=================================================================================
private

def next_move()
	choice_arr = nil
	#first find which player's turn it is
	@current_player_index == 0 ?  @current_player_index = 1 : @current_player_index = 0
	got_choice = false
  
  #this section if its the human's turn - ask human for choice
  if(!@players[@current_player_index].is_computer)
	  while(!got_choice)
			puts "#{@players[@current_player_index].name} your turn...."	
			puts "enter the position. For example enter: 0,0"
			choice_arr = STDIN.gets().chomp.split(",").map{|str| str.to_i}
			#Check if its a valid position and if that position wasn't already taken----
			if(@board.is_legalpos(choice_arr)) 
				got_choice = true
			end
		end
	else #this section if its the computer's turn - ai decides choice **********TO DO *****************
    choice_arr =  @ai.choose_position()
    puts "Computer chose #{choice_arr.inspect}"
	end
	choice_arr # in format [0,0]
end
	

# if winner ? returns the player index else returns false
	def get_winner_and_update_ranks()
		
	  winner = false
    #Following methods will provide parameters necessary to update the ranks while they
    #also check for a winner
    bool_flags = Array.new(4)
	  #bool_flags[0] = scan_rows()
	  bool_flags[0] = scan("rows")
    #bool_flags[1] = scan_cols()
    bool_flags[1] = scan("cols")
    bool_flags[2] = scan_left_diag()
    bool_flags[3] = scan_right_diag()
    if(bool_flags.include?(0))
      winner = 0
    elsif(bool_flags.include?(1))
      winner = 1
    else
      winner = false
    end
    winner
	end
	
	#=====================================================================================
private

def scan(mode)
  winner = false
   (0..@board.boardsize - 1).each do |outer|
     	p0count = 0
    	p1count = 0
    	positions_array = Array.new()
     (0..@board.boardsize - 1).each do |inner|
      if(mode == "rows")
         row = outer
         col = inner
      else
         row = inner
         col = outer
      end #if/else
       
      player = @board.pos_array[row][col].belongs_to
       if(player == 0)
          p0count = p0count + 1
          if (mode == "rows") 
           positions_array[col] = 0 
          elsif (mode == "cols")
           positions_array[row] = 0 
          else
            
          end  
       elsif (player == 1)
        p1count = p1count + 1
        if(mode == "rows") 
          positions_array[col] = 1
        elsif (mode == "cols")
          positions_array[row] = 1
        else

        end
      else
         if(mode == "rows") 
           positions_array[col] = nil
         elsif (mode == "cols")
           positions_array[row] = nil
         else
         end
       end #if/else
     end #inner
     
     
     if(p0count == 3)
       winner = 0
       break
     elsif(p1count == 3)
       winner = 1
       break
     else # We only update ranks if there is no winner. If there is a winner we dont need to update the ranks
       winner = false
       if(mode == "rows") then @ai.update_row_col_ranks(positions_array, outer, p0count, p1count, "row" ) end
       if(mode == "cols") then @ai.update_row_col_ranks(positions_array, outer, p0count, p1count, "col" ) end
     end #if/else
   end #outer
   winner  
end

 
 def scan_left_diag()
    	p0count = 0
  		p1count = 0
  		winner = false
  		left_diag_positions = Array.new()
      (0..@board.boardsize - 1).each do |i|
          player = @board.pos_array[i][i].belongs_to
            if(player == 0)
              p0count = p0count + 1
              left_diag_positions[i] = 0
            elsif(player == 1)
              p1count = p1count + 1
              left_diag_positions[i] = 1
            else
              left_diag_positions[i] = nil
            end
      end #row
      
      if(p0count == 3)
        winner = 0
      elsif (p1count == 3)
        winner = 1
      else
        winner = false
        @ai.update_diag_ranks(left_diag_positions, p0count, p1count, "left_diag")
      end
      winner
 end
 
 def scan_right_diag()
     	p0count = 0
   		p1count = 0
   		winner = false
   		right_diag_positions = Array.new()
   		r =  ((@board.boardsize - 1)..0)
       (r.first).downto(r.last).each do |row|
           player = @board.pos_array[row][(@board.boardsize - 1) - row].belongs_to
             if(player == 0)
               p0count = p0count + 1
               right_diag_positions[(@board.boardsize - 1) - row] = 0
             elsif(player == 1)
               p1count = p1count + 1
               right_diag_positions[row] = 1
             else
               right_diag_positions[row] = nil
             end
       end #row
       
       if(p0count == 3)
         winner = 0
       elsif (p1count == 3)
         winner = 1
       else
         winner = false
         @ai.update_diag_ranks(right_diag_positions, p0count, p1count, "right_diag")
       end
       winner
  end
  
  

end