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
			#@board.print_ranks()
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



  def num_vacant_positions_left()
    puts "Total board positions are #{@board.total_positions}"
    puts "Total occupied positions = #{@board.occupied_positions}"
    @board.total_positions - @board.occupied_positions
  end



#=================================================================================
private
#TO DO--------
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
    #choice_arr =  @ai.choose_position()
	  choice_arr = [2,2]
	end
	choice_arr # in format [0,0]
end
	

# if winner ? returns the player index else returns false
	def get_winner_and_update_ranks()
		puts "Inside method to check if there is a winner"
	  winner = false
    #Following methods will provide parameters necessary to update the ranks while they
    #also check for a winner
    bool_flags = Array.new(4)
	  bool_flags[0] = scan_rows()
    bool_flags[1] = scan_cols()
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

  def scan_rows()
   		winner = false
       (0..@board.boardsize - 1).each do |row|
         	p0count = 0
        	p1count = 0
        	row_positions = Array.new()
         (0..@board.boardsize - 1).each do |col|
           player = @board.pos_array[row][col].belongs_to
             if(player == 0)
               p0count = p0count + 1
               row_positions[col] = 0
               #puts "[#{row}][#{col}] is occupied by player[0]"
             elsif(player == 1)
               p1count = p1count + 1
               row_positions[col] = 1
               #puts "[#{row}][#{col}] is occupied by player[1]"
             else
               #puts "[#{row}][#{col}] is empty"
               row_positions[col] = nil
             end
         end #col
         if(p0count == 3)
           #puts "Winner 0 in row = #{row}"
           winner = 0
           break
         elsif(p1count == 3)
            #puts "Winner 1 in row = #{row}"
           winner = 1
           break
         else # We only update ranks if there is no winner. If there is a winner we dont need to update the ranks
           #puts "No winner in row = #{row}"
           winner = false
           @ai.update_row_ranks(row_positions, row, p0count, p1count)
         end
       end #row
       winner
   end


 def scan_cols()
   #0,2puts "Inside method to check cols for a winner"
 		winner = false
     (0..@board.boardsize - 1).each do |col|
       	p0count = 0
      	p1count = 0
      	col_positions = Array.new()
       (0..@board.boardsize - 1).each do |row|
         player = @board.pos_array[row][col].belongs_to
           if(player == 0)
             p0count = p0count + 1
             col_positions[row] = 0
             #puts "[#{row}][#{col}] is occupied by player[0]"
           elsif(player == 1)
             p1count = p1count + 1
             col_positions[row] = 1
             #puts "[#{row}][#{col}] is occupied by player[1]"
           else
             #puts "[#{row}][#{col}] is empty"
             col_positions[row] = nil
           end
       end #row
      
       if(p0count == 3)
         #puts "Winner 0 in col = #{col}"
         winner = 0
         break
       elsif (p1count == 3)
          #puts "Winner 1 in col = #{col}"
         winner = 1
         break
       else
         #puts "No winner in col = #{col}"
         winner = false
         #update ranks in this col-------TO DO
         @ai.update_col_ranks(col_positions, col, p0count, p1count)
       end
     end #col
     winner
 end
 
 def scan_left_diag()
   #puts "Inside method to check left diagonal for a winner"
    	p0count = 0
  		p1count = 0
  		winner = false
  		left_diag_positions = Array.new()
      (0..@board.boardsize - 1).each do |i|
          player = @board.pos_array[i][i].belongs_to
            if(player == 0)
              p0count = p0count + 1
              left_diag_positions[i] = 0
              #puts "[#{i}][#{i}] is occupied by player[0]"
            elsif(player == 1)
              p1count = p1count + 1
              left_diag_positions[i] = 1
              #puts "[#{i}][#{i}] is occupied by player[1]"
            else
              #puts "[#{i}][#{i}] is empty"
              left_diag_positions[i] = nil
            end
      end #row
      
      if(p0count == 3)
        #puts "Winner 0 in left diagonal"
        winner = 0
      elsif (p1count == 3)
         #puts "Winner 1 in left diagonal"
        winner = 1
      else
        #puts "No winner in left diagonal"
        winner = false
        #update ranks in left diagonal-------TO DO
        @ai.update_leftdiag_ranks(left_diag_positions, p0count, p1count)
      end
      winner
 end
 
 def scan_right_diag()
    #puts "Inside method to check cols for a winner"
     	p0count = 0
   		p1count = 0
   		winner = false
   		right_diag_positions = Array.new()
   		r =  ((@board.boardsize - 1)..0)
       (r.first).downto(r.last).each do |row|
           player = @board.pos_array[row][(@board.boardsize - 1) - row].belongs_to
             if(player == 0)
               p0count = p0count + 1
               #puts "[#{row}][#{row}] is occupied by player[0]"
               right_diag_positions[(@board.boardsize - 1) - row] = 0
             elsif(player == 1)
               p1count = p1count + 1
               #puts "[#{row}][#{@board.boardsize - 1) - row}] is occupied by player[1]"
               right_diag_positions[row] = 1
             else
               #puts "[#{row}][#{@board.boardsize - 1) - row}] is empty"
               right_diag_positions[row] = nil
             end
       end #row
       
       if(p0count == 3)
         #puts "Winner 0 in right diagonal"
         winner = 0
       elsif (p1count == 3)
          #puts "Winner 1 in right diagonal"
         winner = 1
       else
         #puts "No winner in right diagonal"
         winner = false
         #update ranks in right diagonal-------TO DO
         @ai.update_rightdiag_ranks(right_diag_positions, p0count, p1count)
       end
       winner
  end
  
  
#TO DO --TO OPTIMIZE AND CONSOLIDATE INTO 1 METHOD
 # def check_rows_or_cols_for_winner(mode)
 #    puts "Inside method to check #{mode} for a winner"
 #      p0count = 0
 #      p1count = 0
 #      winner = false
 #      puts "Mode = #{mode}"
 #      (0..@board.boardsize - 1).each do |row|
 #        (0..@board.boardsize - 1).each do |col|
 #          if(mode == "rows") 
 #            outer = row
 #            inner = col
 #          else
 #            outer = col
 #            inner = row
 #          end
 #          puts "outer = [#{outer}] inner = [#{inner}]"   
 #          player = @board.pos_array[outer][inner].belongs_to
 #          if(player == 0)
 #           p0count = p0count + 1
 #           puts "[#{outer}][#{inner}] is occupied by player[0]"
 #          elsif(player == 1)
 #           p1count = p1count + 1
 #           puts "[#{outer}][#{inner}] is occupied by player[1]"
 #          else
 #           puts "[#{outer}][#{inner}] is empty"
 #          end
 #        end #col
 #        if(p0count == 3)
 #         puts "Winner 0 in #{mode} = #{outer}"
 #         winner = 0
 #         break
 #       elsif (p1count == 3)
 #         puts "Winner  1 in #{mode} = #{outer}"
 #         winner = 1
 #         break
 #       else
 #         puts "No winner in #{mode} = #{outer}"
 #         winner = false
 #         p0count = 0
 #         p1count = 0
 #      end
 #     end #row
 #      winner
 #  end


end