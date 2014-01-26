#!/usr/bin/ruby
class Ai
  
  
  require_relative 'player'
  require_relative 'game'
  require_relative 'board'
  require_relative 'ai'
    
  attr_accessor :players, :game, :pos_rank_hash
  
  
  #TO DO--------
  def initialize(players, game, board)
    @players = players
    @game = game
    @board = board
    
    puts "AI.game instance_of #{@game.instance_of?(Game)}"
    puts "AI.game kind_of #{@game.kind_of?(Game)}"
    puts "AI is activated... "
  end
  
  #method only invoked if there is at least 1 position unoccupied in that row
  #only empty positions get ranks
 def update_row_ranks(row_positions, row, p0count, p1count)
  puts "row_positions = #{row_positions}"
  puts "row = #{row}"
  puts "p0count = #{p0count}"
  puts "p1count = #{p1count}"
  row_positions.each_with_index do |val, i|
      puts "Inside update_row_ranks row2, = #{row} #{i} "
      pos = @board.pos_array[row][i]
      if(row_positions[i].nil?)
            #Rule
            if(p0count == 0 && p1count == 0 )
              pos.rank0 < 3 ? pos.rank0 = evaluate_rank_of_position(row,i, 0, pos.rank0, 3, "row") : pos.rank0 = 3 
              pos.rank1 < 3 ? pos.rank1 = evaluate_rank_of_position(row,i, 1, pos.rank1, 3, "row") : pos.rank1 = 3 
            elsif(p0count == 0 && p1count == 1 )
              pos.rank0 < 9 ? pos.rank0 = evaluate_rank_of_position(row,i, 0, pos.rank0, 9, "row") : pos.rank0 = 9 
              pos.rank1 < 2 ? pos.rank1 = evaluate_rank_of_position(row,i, 1, pos.rank1, 2, "row") : pos.rank1 = 2
            elsif(p0count == 1 && p1count == 0 )
              pos.rank0 < 2 ? pos.rank0 = evaluate_rank_of_position(row,i, 0, pos.rank0, 2, "row") : pos.rank0 = 2 
              pos.rank1 < 9 ? pos.rank1 = evaluate_rank_of_position(row,i, 1, pos.rank1, 9, "row") : pos.rank1 = 9
            elsif(p0count == 1 && p1count == 1 )
              pos.rank0 < 9 ? pos.rank0 = evaluate_rank_of_position(row,i, 0, pos.rank0, 9, "row") : pos.rank0 = 9 
              pos.rank1 < 9 ? pos.rank1 = evaluate_rank_of_position(row,i, 1, pos.rank1, 9, "row") : pos.rank1 = 9
            elsif(p0count == 0 && p1count == 2 )
              pos.rank0 < 9 ? pos.rank0 = evaluate_rank_of_position(row,i, 0, pos.rank0, 9, "row") : pos.rank0 = 9 
              pos.rank1 == 1 ? (puts "Rank unchanged from #{pos.rank1} ") : pos.rank1 = 1
            elsif(p0count == 2 && p1count == 0 )
              pos.rank0 == 1 ? (puts "Rank unchanged from #{pos.rank0} ") : pos.rank0 = 1 
              pos.rank1 < 9 ? pos.rank1 = evaluate_rank_of_position(row,i, 1, pos.rank1, 9, "row") : pos.rank1 = 9
            elsif(p0count == 1 && p1count == 2 )
              pos.rank0 < 9 ? pos.rank0 = evaluate_rank_of_position(row,i, 0, pos.rank0, 9, "row") : pos.rank0 = 9 
              pos.rank1 < 9 ? pos.rank1 = evaluate_rank_of_position(row,i, 1, pos.rank1, 9, "row") : pos.rank1 = 9
            else
              pos.rank0 < 9 ? pos.rank0 = evaluate_rank_of_position(row,i, 0, pos.rank0, 9, "row") : pos.rank0 = 9 
              pos.rank1 < 9 ? pos.rank1 = evaluate_rank_of_position(row,i, 1, pos.rank1, 9, "row") : pos.rank1 = 9
            end    
          end
    end #loop
 end
 
 
 #method only invoked if there is at least 1 position unoccupied in that col
 #only empty positions get ranks
def update_col_ranks(col_positions, col, p0count, p1count)
 puts "col_positions = #{col_positions}"
 puts "col = #{col}"
 puts "p0count = #{p0count}"
 puts "p1count = #{p1count}"
 col_positions.each_with_index do |val, i|
     puts "Inside update_col_ranks, = #{i} #{col} "
     pos = @board.pos_array[i][col]
     if(col_positions[i].nil?)
           #Rule
           if(p0count == 0 && p1count == 0 )
             pos.rank0 < 3 ? pos.rank0 = evaluate_rank_of_position(i,col, 0, pos.rank0, 3, "col") : pos.rank0 = 3 
             pos.rank1 < 3 ? pos.rank1 = evaluate_rank_of_position(i,col, 1, pos.rank1, 3, "col") : pos.rank1 = 3 
           elsif(p0count == 0 && p1count == 1 )
             pos.rank0 < 9 ? pos.rank0 = evaluate_rank_of_position(i,col, 0, pos.rank0, 9, "col") : pos.rank0 = 9 
             pos.rank1 < 2 ? pos.rank1 = evaluate_rank_of_position(i,col, 1, pos.rank1, 2, "col") : pos.rank1 = 2
           elsif(p0count == 1 && p1count == 0 )
             pos.rank0 < 2 ? pos.rank0 = evaluate_rank_of_position(i,col, 0, pos.rank0, 2, "col") : pos.rank0 = 2 
             pos.rank1 < 9 ? pos.rank1 = evaluate_rank_of_position(i,col, 1, pos.rank1, 9, "col") : pos.rank1 = 9
           elsif(p0count == 1 && p1count == 1 )
             pos.rank0 < 9 ? pos.rank0 = evaluate_rank_of_position(i,col, 0, pos.rank0, 9, "col") : pos.rank0 = 9 
             pos.rank1 < 9 ? pos.rank1 = evaluate_rank_of_position(i,col, 1, pos.rank1, 9, "col") : pos.rank1 = 9
           elsif(p0count == 0 && p1count == 2 )
             pos.rank0 < 9 ? pos.rank0 = evaluate_rank_of_position(i,col, 0, pos.rank0, 9, "col") : pos.rank0 = 9 
             pos.rank1 == 1 ? (puts "Rank unchanged from #{pos.rank1} ") : pos.rank1 = 1
           elsif(p0count == 2 && p1count == 0 )
             pos.rank0 == 1 ? (puts "Rank unchanged from #{pos.rank0} ") : pos.rank0 = 1 
             pos.rank1 < 9 ? pos.rank1 = evaluate_rank_of_position(i,col, 1, pos.rank1, 9, "col") : pos.rank1 = 9
           elsif(p0count == 1 && p1count == 2 )
             pos.rank0 < 9 ? pos.rank0 = evaluate_rank_of_position(i,col, 0, pos.rank0, 9, "col") : pos.rank0 = 9 
             pos.rank1 < 9 ? pos.rank1 = evaluate_rank_of_position(i,col, 1, pos.rank1, 9, "col") : pos.rank1 = 9
           else
             pos.rank0 < 9 ? pos.rank0 = evaluate_rank_of_position(i,col, 0, pos.rank0, 9, "col") : pos.rank0 = 9 
             pos.rank1 < 9 ? pos.rank1 = evaluate_rank_of_position(i,col, 1, pos.rank1, 9, "col") : pos.rank1 = 9
           end    
         end
   end #loop
end




 #method only invoked if there is at least 1 empty position in the diagonal
 #only empty positions get ranks
def update_leftdiag_ranks(left_diag_positions, p0count, p1count)
 puts "left_diag_positions = #{left_diag_positions}"
 puts "p0count = #{p0count}"
 puts "p1count = #{p1count}"
 (0..@board.boardsize - 1).each do |i|
     puts "Inside update_leftdiag_ranks [#{i}][#{i}] "
     pos = @board.pos_array[i][i]
     if(left_diag_positions[i].nil?)
           #Rule
            if(p0count == 0 && p1count == 0 )
               pos.rank0 < 3 ? pos.rank0 = evaluate_rank_of_position(i,i, 0, pos.rank0, 3, "left_diag") : pos.rank0 = 3 
               pos.rank1 < 3 ? pos.rank1 = evaluate_rank_of_position(i,i, 1, pos.rank1, 3, "left_diag") : pos.rank1 = 3 
             elsif(p0count == 0 && p1count == 1 )
               pos.rank0 < 9 ? pos.rank0 = evaluate_rank_of_position(i,i, 0, pos.rank0, 9, "left_diag") : pos.rank0 = 9 
               pos.rank1 < 2 ? pos.rank1 = evaluate_rank_of_position(i,i, 1, pos.rank1, 2, "left_diag") : pos.rank1 = 2
             elsif(p0count == 1 && p1count == 0 )
               pos.rank0 < 2 ? pos.rank0 = evaluate_rank_of_position(i,i, 0, pos.rank0, 2, "left_diag") : pos.rank0 = 2 
               pos.rank1 < 9 ? pos.rank1 = evaluate_rank_of_position(i,i, 1, pos.rank1, 9, "left_diag") : pos.rank1 = 9
             elsif(p0count == 1 && p1count == 1 )
               pos.rank0 < 9 ? pos.rank0 = evaluate_rank_of_position(i,i, 0, pos.rank0, 9, "left_diag") : pos.rank0 = 9 
               pos.rank1 < 9 ? pos.rank1 = evaluate_rank_of_position(i,i, 1, pos.rank1, 9, "left_diag") : pos.rank1 = 9
             elsif(p0count == 0 && p1count == 2 )
               pos.rank0 < 9 ? pos.rank0 = evaluate_rank_of_position(i,i, 0, pos.rank0, 9, "left_diag") : pos.rank0 = 9 
               pos.rank1 == 1 ? (puts "Rank unchanged from #{pos.rank1} ") : pos.rank1 = 1
             elsif(p0count == 2 && p1count == 0 )
               pos.rank0 == 1 ? (puts "Rank unchanged from #{pos.rank0} ") : pos.rank0 = 1 
               pos.rank1 < 9 ? pos.rank1 = evaluate_rank_of_position(i,i, 1, pos.rank1, 9, "left_diag") : pos.rank1 = 9
             elsif(p0count == 1 && p1count == 2 )
               pos.rank0 < 9 ? pos.rank0 = evaluate_rank_of_position(i,i, 0, pos.rank0, 9, "left_diag") : pos.rank0 = 9 
               pos.rank1 < 9 ? pos.rank1 = evaluate_rank_of_position(i,i, 1, pos.rank1, 9, "left_diag") : pos.rank1 = 9
             else
               pos.rank0 < 9 ? pos.rank0 = evaluate_rank_of_position(i,i, 0, pos.rank0, 9, "left_diag") : pos.rank0 = 9 
               pos.rank1 < 9 ? pos.rank1 = evaluate_rank_of_position(i,i, 1, pos.rank1, 9, "left_diag") : pos.rank1 = 9
             end    
           end
   end #loop
end
  
  
  
  
  #method only invoked if there is at least 1 empty position in the diagonal
   #only empty positions get ranks
  def update_rightdiag_ranks(right_diag_positions, p0count, p1count)
   puts "right_diag_positions = #{right_diag_positions}"
   puts "p0count = #{p0count}"
   puts "p1count = #{p1count}"
   r =  ((@board.boardsize - 1)..0)
    (r.first).downto(r.last).each do |i|
       puts "Inside update_rightdiag_ranks [#{i}][#{(@board.boardsize - 1) - i}] "
       pos = @board.pos_array[i][(@board.boardsize - 1)-i] 
       if(right_diag_positions[i].nil?)
             #Rule
             if(p0count == 0 && p1count == 0 )
               pos.rank0 < 3 ? (puts "Rank unchanged from #{pos.rank0} ") : pos.rank0 = 3 
               pos.rank1 < 3 ? (puts "Rank unchanged from #{pos.rank1} ") : pos.rank1 = 3 
             elsif(p0count == 0 && p1count == 1 )
               pos.rank0 < 9 ? (puts "Rank unchanged from #{pos.rank0} ") : pos.rank0 = 9 
               pos.rank1 < 2 ? (puts "Rank unchanged from #{pos.rank1} ") : pos.rank1 = 2
             elsif(p0count == 1 && p1count == 0 )
               pos.rank0 < 2 ? (puts "Rank unchanged from #{pos.rank0} ") : pos.rank0 = 2 
               pos.rank1 < 9 ? (puts "Rank unchanged from #{pos.rank1} ") : pos.rank1 = 9
             elsif(p0count == 1 && p1count == 1 )
               pos.rank0 < 9 ? (puts "Rank unchanged from #{pos.rank0} ") : pos.rank0 = 9 
               pos.rank1 < 9 ? (puts "Rank unchanged from #{pos.rank1} ") : pos.rank1 = 9
             elsif(p0count == 0 && p1count == 2 )
               pos.rank0 < 9 ? (puts "Rank unchanged from #{pos.rank0} ") : pos.rank0 = 9 
               pos.rank1 == 1 ? (puts "Rank unchanged from #{pos.rank1} ") : pos.rank1 = 1
             elsif(p0count == 2 && p1count == 0 )
               pos.rank0 == 1 ? (puts "Rank unchanged from #{pos.rank0} ") : pos.rank0 = 1 
               pos.rank1 < 9 ? (puts "Rank unchanged from #{pos.rank1} ") : pos.rank1 = 9
             elsif(p0count == 1 && p1count == 2 )
               pos.rank0 < 9 ? (puts "Rank unchanged from #{pos.rank0} ") : pos.rank0 = 9 
               pos.rank1 < 9 ? (puts "Rank unchanged from #{pos.rank1} ") : pos.rank1 = 9
             else
               pos.rank0 < 9 ? (puts "Rank unchanged from #{pos.rank0} ") : pos.rank0 = 9 
               pos.rank1 < 9 ? (puts "Rank unchanged from #{pos.rank1} ") : pos.rank1 = 9
             end    
           end
     end #loop
  end
  
  # Ranking hash constructed by AI ranks_r0= {1=>[], 2=>[[0, 1], [0, 2], [1, 0], [1, 1], [2, 0], [2, 2]], 3=>[[1, 2], [2, 1]], "other"=>[]}
  #   Ranking hash constructed by AI ranks_r1= {1=>[], 2=>[], 3=>[[0, 1], [0, 2], [1, 0], [1, 1], [1, 2], [2, 0], [2, 1], [2, 2]], "other"=>[]}
  #   Empty Positions [[0, 1], [0, 2], [1, 0], [1, 1], [1, 2], [2, 0], [2, 1], [2, 2]]
  #Precondition = This position must be unoccupied for it to be ranked     
  def evaluate_rank_of_position(row,col, player_index, old_rank, new_rank, sending_function)
    lowest_rank = new_rank

    ranks = {"row_rank"=>9, "col_rank"=>9,"left_diag_rank"=>9, "right_diag_rank"=>9 }
    #if sending function is row -> evaluate col and if row==col -> evaluate  left_diag and if coordinate exists in right diagonal -> evaluate right diagonal
    if (sending_function == "row")
     ranks["row_rank"] = evaluate_column(row, col, player_index)
     if(row == col) then ranks["left_diag_rank"] = evaluate_left_diag(row, col, player_index) end
     if([[2,0], [1,1], [0,2]].include?([row,col])) then ranks["right_diag_rank"] = evaluate_right_diag(row, col, player_index) end
        puts "ranks.inspect = #{ranks.inspect}"
        ranks.keys.each do |key|
          puts "ranks[key] = #{ranks[key]} lowest_rank = #{lowest_rank}"
          if(ranks[key] < lowest_rank)
            lowest_rank = ranks[key]
          end
        end #loop
    elsif (sending_function == "col")#if sending function is col -> evaluate row and if row==col -> evaluate  left_diag and if coordinate exists in right diagonal -> evaluate right diagonal 
       ranks["col_rank"] = evaluate_row(row, col, player_index)
       if(row == col) then ranks["left_diag_rank"] = evaluate_left_diag(row, col, player_index) end
       if([[2,0], [1,1], [0,2]].include?([row,col])) then ranks["right_diag_rank"] = evaluate_right_diag(row, col, player_index) end

         ranks.keys.each do |key|
           puts "ranks[key] = #{ranks[key]} lowest_rank = #{lowest_rank}"
           if(ranks[key] < lowest_rank)
             lowest_rank = ranks[key]
           end
         end #loop
    else #if sending function is right_diag -> evaluate col and row
       ranks["row_rank"] = evaluate_column(row, col, player_index)
       ranks["col_rank"] = evaluate_row(row, col, player_index)
       ranks.keys.each do |key|
         puts "ranks[key] = #{ranks[key]} lowest_rank = #{lowest_rank}"
         if(ranks[key] < lowest_rank)
           lowest_rank = ranks[key]
         end
       end #loop
    end #ifelse
  puts "reevaluated rank for [#{row}][#{col}] from #{old_rank} to #{lowest_rank}"
  lowest_rank
  end
 
 
   #Precondition = This position must be unoccupied for it to be ranked     
    def evaluate_row(row, col, player_index)
      p0count = 0
      p1count = 0
      player_rank = nil
      
      (0..@board.boardsize - 1).each do |c|
        current_pos = @board.pos_array[row][c]
        player = current_pos.belongs_to
        if(player == 0)
           p0count = p0count + 1
        elsif(player == 1)
           p1count = p1count + 1
        else
           #evaluating row : position> "[#{row}][#{col}] is empty"
        end
      end #loop
      
      if(p0count == 0 && p1count == 0 )
        player_index == 0 ? (player_rank = 3) : (player_rank = 3)
       elsif(p0count == 0 && p1count == 1 )
        player_index == 0 ? (player_rank = 9) : (player_rank = 2)
       elsif(p0count == 1 && p1count == 0 )
        player_index == 0 ? (player_rank = 2) : (player_rank = 9)
       elsif(p0count == 1 && p1count == 1 )
        player_index == 0 ? (player_rank = 9) : (player_rank = 9)        
       elsif(p0count == 0 && p1count == 2 )
        player_index == 0 ? (player_rank = 9) : (player_rank = 1)
       elsif(p0count == 2 && p1count == 0 )
        player_index == 0 ? (player_rank = 1) : (player_rank = 9)
       elsif(p0count == 1 && p1count == 2 )
        player_index == 0 ? (player_rank = 9) : (player_rank = 9)
       else
        player_index == 0 ? (player_rank = 9) : (player_rank = 9)
       end
       puts "Exiting evaluate_row() with player_rank = #{player_rank} "
      player_rank
    end
 
 
     def evaluate_column(row, col, player_index)
          p0count = 0
           p1count = 0
           player_rank = nil
           (0..@board.boardsize - 1).each do |r|
             current_pos = @board.pos_array[r][col]
             player = current_pos.belongs_to
             if(player == 0)
                p0count = p0count + 1
              elsif(player == 1)
                p1count = p1count + 1
              else
                #evaluating row : position> "[#{row}][#{col}] is empty"
              end
           end #loop

            if(p0count == 0 && p1count == 0 )
              player_index == 0 ? (player_rank = 3) : (player_rank = 3)
             elsif(p0count == 0 && p1count == 1 )
              player_index == 0 ? (player_rank = 9) : (player_rank = 2)
             elsif(p0count == 1 && p1count == 0 )
              player_index == 0 ? (player_rank = 2) : (player_rank = 9)
             elsif(p0count == 1 && p1count == 1 )
              player_index == 0 ? (player_rank = 9) : (player_rank = 9)        
             elsif(p0count == 0 && p1count == 2 )
              player_index == 0 ? (player_rank = 9) : (player_rank = 1)
             elsif(p0count == 2 && p1count == 0 )
              player_index == 0 ? (player_rank = 1) : (player_rank = 9)
             elsif(p0count == 1 && p1count == 2 )
              player_index == 0 ? (player_rank = 9) : (player_rank = 9)
             else
              player_index == 0 ? (player_rank = 9) : (player_rank = 9)
             end
             puts "Exiting evaluate_column() with player_rank = #{player_rank} "
           player_rank
      end
 
 
      def evaluate_left_diag(row, col, player_index)
        p0count = 0
         p1count = 0
         player_rank = nil
         (0..@board.boardsize - 1).each do |i|
           current_pos = @board.pos_array[i][i]
           player = current_pos.belongs_to
           if(player == 0)
              p0count = p0count + 1
            elsif(player == 1)
              p1count = p1count + 1
            else
              #evaluating row : position> "[#{row}][#{col}] is empty"
            end
         end

           if(p0count == 0 && p1count == 0 )
              player_index == 0 ? (player_rank = 3) : (player_rank = 3)
             elsif(p0count == 0 && p1count == 1 )
              player_index == 0 ? (player_rank = 9) : (player_rank = 2)
             elsif(p0count == 1 && p1count == 0 )
              player_index == 0 ? (player_rank = 2) : (player_rank = 9)
             elsif(p0count == 1 && p1count == 1 )
              player_index == 0 ? (player_rank = 9) : (player_rank = 9)        
             elsif(p0count == 0 && p1count == 2 )
              player_index == 0 ? (player_rank = 9) : (player_rank = 1)
             elsif(p0count == 2 && p1count == 0 )
              player_index == 0 ? (player_rank = 1) : (player_rank = 9)
             elsif(p0count == 1 && p1count == 2 )
              player_index == 0 ? (player_rank = 9) : (player_rank = 9)
             else
              player_index == 0 ? (player_rank = 9) : (player_rank = 9)
             end
             puts "Exiting evaluate_leftdiag() with player_rank = #{player_rank} "
         player_rank
      end
 
       def evaluate_right_diag(row, col, player_index)
          	p0count = 0
         		p1count = 0
         		player_rank = nil
         		r =  ((@board.boardsize - 1)..0)
             (r.first).downto(r.last).each do |i|#Iteration pattern = 20, 11, 02 
                 current_pos = @board.pos_array[i][(@board.boardsize - 1) - i]
                 player = current_pos.belongs_to
                   if(player == 0)
                     p0count = p0count + 1
                   elsif(player == 1)
                     p1count = p1count + 1
                   else
                     #puts "[#{row}][#{@board.boardsize - 1) - row}] is empty"
                   end
             end 

              if(p0count == 0 && p1count == 0 )
                  player_index == 0 ? (player_rank = 3) : (player_rank = 3)
                elsif(p0count == 0 && p1count == 1 )
                  player_index == 0 ? (player_rank = 9) : (player_rank = 2)
                elsif(p0count == 1 && p1count == 0 )
                  player_index == 0 ? (player_rank = 2) : (player_rank = 9)
                elsif(p0count == 1 && p1count == 1 )
                  player_index == 0 ? (player_rank = 9) : (player_rank = 9)        
                elsif(p0count == 0 && p1count == 2 )
                  player_index == 0 ? (player_rank = 9) : (player_rank = 1)
                elsif(p0count == 2 && p1count == 0 )
                  player_index == 0 ? (player_rank = 1) : (player_rank = 9)
                elsif(p0count == 1 && p1count == 2 )
                  player_index == 0 ? (player_rank = 9) : (player_rank = 9)
                else
                  player_index == 0 ? (player_rank = 9) : (player_rank = 9)
                end
                puts "Exiting evaluate_rightdiag() with player_rank = #{player_rank} "
              player_rank
        end
 
  
  
 #Prior to making a choice, all ranks of the board positions must be updated
 def choose_position()
  choice = Array.new()
  #Construct hash where keys are number of moves
  #All the positions which have a rank of 1 for player 0 = opponent
  pos_P0_by_ranks = {1=>Array.new(), 2=>Array.new(), 3=>Array.new(), "other"=>Array.new() }
  #All the positions which have a rank of 1 for player 1 = Computer
  pos_P1_by_ranks = {1=>Array.new(), 2=>Array.new(), 3=>Array.new(), "other"=>Array.new() }
  empty_positions = Array.new()
  @board.pos_array.each do |row| #Iterate through board and collect empty positions by their ranks
    row.each do |pos|
      if(pos.belongs_to.nil?)
        (empty_positions << pos.coordinates) 
        (pos_P0_by_ranks[1] << pos.coordinates) if(pos.rank0 == 1) # All opponents positions that are ranked 1
        (pos_P1_by_ranks[1] << pos.coordinates) if(pos.rank1 == 1) # All computers positions that are ranked 1
        (pos_P0_by_ranks[2] << pos.coordinates) if(pos.rank0 == 2) # All opponents positions that are ranked 2
        (pos_P1_by_ranks[2] << pos.coordinates) if(pos.rank1 == 2) # All computers positions that are ranked 2
        (pos_P0_by_ranks[3] << pos.coordinates) if(pos.rank0 == 3)
        (pos_P1_by_ranks[3] << pos.coordinates) if(pos.rank1 == 3)
        (pos_P0_by_ranks["other"] << pos.coordinates) if(pos.rank0 > 3)
        (pos_P1_by_ranks["other"] << pos.coordinates) if(pos.rank1 > 3)          
      end
    end
  end
  
  puts "==========="
  puts "==========="
    puts "Ranking hash constructed by AI pos_P0_by_ranks= #{pos_P0_by_ranks.inspect}"  
    puts "Ranking hash constructed by AI pos_P1_by_ranks= #{pos_P1_by_ranks.inspect}"  
    puts "Empty Positions #{empty_positions.inspect}"
  puts "==========="
  puts "==========="
   
   choice_hash = {1=>Array.new(), 2=>Array.new(), 3=>Array.new(), 4=>Array.new()}
   i=1
   while(i<=3)
     choice_hash[i] << pos_P1_by_ranks[i] if(pos_P1_by_ranks[i].any?)
     choice_hash[i] << pos_P0_by_ranks[i] if(pos_P0_by_ranks[i].any?)  
     i += 1
   end
   
   puts "==========="
   puts "==========="
   puts "choice_hash = #{choice_hash.inspect}"
    puts "==========="
    puts "===========" 
    #Clean up formatting of choice hash
    choice_hash.keys.each do |key|
      if(choice_hash[key].any?)
        choice_hash[key] = choice_hash[key].join(",").split(",").map{|x| x.to_i }
        choice_hash[key] = choice_hash[key].each_slice(2).to_a
      end
    end
    
    puts "choice_hash after cleanup = #{choice_hash.inspect}"
    puts "choice_hash[1].any? = #{choice_hash[1].any?}"
    puts "choice_hash[2].size = #{choice_hash[2].size}"
    if(!choice_hash[1].any? && choice_hash[2].size > 1)
      choice_hash[2] = reorder_array_of_positions_on_priorities(choice_hash[2])
    end
    
    
   choice << choice_hash[1] if(choice_hash[1].any?)
   choice << choice_hash[2] if(choice_hash[2].any?)
   choice << choice_hash[3] if(choice_hash[3].any?)
   choice = choice.join(",").split(",").map{|x| x.to_i }.each_slice(2).to_a
  puts "choice = #{choice.inspect}"
  if(!choice.any? || choice.nil?)
    choice = empty_positions[rand(empty_positions.size)]
  end
  #Convert the choice from an array of numbers to an array of tuples
  #choice = choice.each_slice(2).to_a
  #puts "choice = #{choice.inspect}"
  puts "Computer chose #{choice[0]}"
  choice[0]
 end
 
 
 
 
 def reorder_array_of_positions_on_priorities(array_of_positions)
   corners = [[0,0], [0,2], [2,2], [2,0]]
   reordered_array = Array.new()
   if(array_of_positions.include?([1,1]))
     reordered_array << [1,1]
   end
   
   common_elems = array_of_positions & corners
   
   if(common_elems.size >= 1)
     reordered_array << common_elems
   end
   #reordered_array should now contain [1,1], corners
   puts "reordered_array = #{reordered_array.inspect}"
   #Now add anything that is missing in reordered_positions as compared to array_of_positions
   array_diff = array_of_positions - reordered_array
   reordered_array << array_diff
   reordered_array = reordered_array.join(",").split(",").map{|x| x.to_i }.each_slice(2).to_a
   puts "Final version of reordered array = #{reordered_array}"   
   reordered_array
 end


  
end