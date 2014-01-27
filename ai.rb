#!/usr/bin/ruby
class Ai
  
  
  require_relative 'player'
  require_relative 'game'
  require_relative 'board'
  require_relative 'ai'
    
  attr_accessor :players, :game, :pos_rank_hash

  def initialize(players, game, board)
    @players = players
    @game = game
    @board = board
    
    puts "AI.game instance_of #{@game.instance_of?(Game)}"
    puts "AI.game kind_of #{@game.kind_of?(Game)}"
    puts "AI is activated... "
  end
  
 
#=================================================================================================
def update_row_col_ranks(positions_array, row_or_col, p0count, p1count, mode )
  r0_ranks = {"00"=>3, "01"=>9, "10"=>2, "11"=>9, "02"=> 9, "20"=>1, "12"=>9, "21"=>9}
  r1_ranks = {"00"=>3, "01"=>2, "10"=>9, "11"=>9, "02"=> 1, "20"=>9, "12"=>9, "21"=>9}
  
  positions_array.each_with_index do |elem, i |
  case mode
  when "row"
    left = row_or_col
    right = i
    pos = @board.pos_array[left][right]
  when "col"
    left = i
    right = row_or_col
    pos = @board.pos_array[left][right]
  else
    puts "incorrect mode"
  end
  
    if(positions_array[i].nil?)
        #Rules
      val = "#{p0count}#{p1count}" 
      if(val == "02")
         pos.rank0 < r0_ranks[val] ? pos.rank0 = evaluate_rank_of_position(left, right, 0, pos.rank0, r0_ranks[val], mode) : pos.rank0 = r0_ranks[val] 
         pos.rank1 == r1_ranks[val] ? (puts "Rank unchanged from #{pos.rank1} ") : pos.rank1 = r1_ranks[val]
      elsif(val == "20" )
        pos.rank0 == r0_ranks[val] ? (puts "Rank unchanged from #{pos.rank0} ") : pos.rank0 = r0_ranks[val] 
        pos.rank1 < r1_ranks[val] ? pos.rank1 = evaluate_rank_of_position(left, right, 1, pos.rank1, r1_ranks[val], mode) : pos.rank1 = r1_ranks[val]
      else  
        pos.rank0 < r0_ranks[val] ? pos.rank0 = evaluate_rank_of_position(left ,right, 0, pos.rank0, r0_ranks[val], mode) : pos.rank0 = r0_ranks[val] 
        pos.rank1 < r1_ranks[val] ? pos.rank1 = evaluate_rank_of_position(left ,right, 1, pos.rank1, r1_ranks[val], mode) : pos.rank1 = r1_ranks[val]
      end    
    end
  end #loop
end




  #Precondition = This position must be unoccupied for it to be ranked     
  def evaluate_rank_of_position(row,col, player_index, old_rank, new_rank, sending_function)
    puts "Evaluating rank of position #{row},#{col}, old_rank = #{old_rank}, new rank = #{new_rank}, sending function = #{sending_function}-------------------"
    lowest_rank = new_rank

    ranks = {"row_rank"=>9, "col_rank"=>9,"left_diag_rank"=>9, "right_diag_rank"=>9 }
    #if sending function is row -> evaluate col and if row==col -> evaluate  left_diag and if coordinate exists in right diagonal -> evaluate right diagonal
    if (sending_function == "row")
     #ranks["row_rank"] = evaluate_column(row, col, player_index)
     ranks["row_rank"] = evaluate_counts(row, col, player_index, "col")
     #if(row == col) then ranks["left_diag_rank"] = evaluate_left_diag(row, col, player_index) end
     if(row == col) then ranks["left_diag_rank"] = evaluate_counts(row, col, player_index, "left_diag") end
     #if([[2,0], [1,1], [0,2]].include?([row,col])) then ranks["right_diag_rank"] = evaluate_right_diag(row, col, player_index) end
     if([[2,0], [1,1], [0,2]].include?([row,col])) then ranks["right_diag_rank"] = evaluate_counts(row, col, player_index, "right_diag") end
        puts "ranks.inspect = #{ranks.inspect}"
        ranks.keys.each do |key|
          puts "ranks[key] = #{ranks[key]} lowest_rank = #{lowest_rank}"
          if(ranks[key] < lowest_rank)
            lowest_rank = ranks[key]
          end
        end #loop
    elsif (sending_function == "col")#if sending function is col -> evaluate row and if row==col -> evaluate  left_diag and if coordinate exists in right diagonal -> evaluate right diagonal 
       #ranks["col_rank"] = evaluate_row(row, col, player_index)
       ranks["col_rank"] = evaluate_counts(row, col, player_index, "row")
       #if(row == col) then ranks["left_diag_rank"] = evaluate_left_diag(row, col, player_index) end
       if(row == col) then ranks["left_diag_rank"] = evaluate_counts(row, col, player_index, "left_diag") end
       #if([[2,0], [1,1], [0,2]].include?([row,col])) then ranks["right_diag_rank"] = evaluate_right_diag(row, col, player_index) end
       if([[2,0], [1,1], [0,2]].include?([row,col])) then ranks["right_diag_rank"] = evaluate_counts(row, col, player_index, "right_diag") end

         ranks.keys.each do |key|
           puts "ranks[key] = #{ranks[key]} lowest_rank = #{lowest_rank}"
           if(ranks[key] < lowest_rank)
             lowest_rank = ranks[key]
           end
         end #loop
    else #if sending function is left_diag or right_diag -> evaluate col and row
       #ranks["row_rank"] = evaluate_column(row, col, player_index)
       ranks["row_rank"] = evaluate_counts(row, col, player_index, "col")
       #ranks["col_rank"] = evaluate_row(row, col, player_index)
       ranks["col_rank"] = evaluate_counts(row, col, player_index, "row")
       
       #if(row == col) then ranks["left_diag_rank"] = evaluate_left_diag(row, col, player_index) end
       if(row == col) then ranks["left_diag_rank"] = evaluate_counts(row, col, player_index, "left_diag") end
       #if([[2,0], [1,1], [0,2]].include?([row,col])) then ranks["right_diag_rank"] = evaluate_right_diag(row, col, player_index) end
       if([[2,0], [1,1], [0,2]].include?([row,col])) then ranks["right_diag_rank"] = evaluate_counts(row, col, player_index,"left_diag") end

       ranks.keys.each do |key|
         puts "ranks[key] = #{ranks[key]} lowest_rank = #{lowest_rank}"
         if(ranks[key] < lowest_rank)
           lowest_rank = ranks[key]
         end
       end #loop
    end #ifelse
  puts "reevaluated rank for [#{row}][#{col}] from #{old_rank} to #{lowest_rank}------------------"
  lowest_rank
  end
 
 
 def update_diag_ranks(diag_array, p0count, p1count, mode)
  puts "Inside update_diag_ranks-------------------------------"
  puts "mode = #{mode}"
   lim = (@board.boardsize - 1)
   iter_range = (0..lim).to_a
   if(mode == "right_diag") then  iter_range = iter_range.reverse end
   r0_ranks = {"00"=>3, "01"=>9, "10"=>2, "11"=>9, "02"=> 9, "20"=>1, "12"=>9, "21"=>9}
   r1_ranks = {"00"=>3, "01"=>2, "10"=>9, "11"=>9, "02"=> 1, "20"=>9, "12"=>9, "21"=>9}
   puts "Iterating over #{iter_range.inspect}"
  iter_range.each do |i|
   if(mode == "right_diag") 
     row = i
     col = lim - i
   else
     row = i
     col = i
   end
   pos = @board.pos_array[row][col]
   puts "Evaluating position = #{pos.coordinates}"
   if(diag_array[i].nil?)   
       #Rules
     val = "#{p0count}#{p1count}" 
     if(val == "02")
        pos.rank0 < r0_ranks[val] ? pos.rank0 = evaluate_rank_of_position(row, col, 0, pos.rank0, r0_ranks[val], mode) : pos.rank0 = r0_ranks[val] 
        pos.rank1 == r1_ranks[val] ? (puts "Rank unchanged from #{pos.rank1} ") : pos.rank1 = r1_ranks[val]
     elsif(val == "20" )
       pos.rank0 == r0_ranks[val] ? (puts "Rank unchanged from #{pos.rank0} ") : pos.rank0 = r0_ranks[val] 
       pos.rank1 < r1_ranks[val] ? pos.rank1 = evaluate_rank_of_position(row, col, 1, pos.rank1, r1_ranks[val], mode) : pos.rank1 = r1_ranks[val]
     else  
       pos.rank0 < r0_ranks[val] ? pos.rank0 = evaluate_rank_of_position(row ,col, 0, pos.rank0, r0_ranks[val], mode) : pos.rank0 = r0_ranks[val] 
       pos.rank1 < r1_ranks[val] ? pos.rank1 = evaluate_rank_of_position(row ,col, 1, pos.rank1, r1_ranks[val], mode) : pos.rank1 = r1_ranks[val]
     end    
   end #if
   end #loop
   puts "exiting update_diag_ranks-------------------------------"
  end
 

 
 
 
 
  def evaluate_counts(row, col, player_index, mode)
    p0count = 0
    p1count = 0
    player_rank = nil
    lim = (@board.boardsize - 1)
    iter_range = (0..lim).to_a
    if(mode == "right_diag") then  iter_range = iter_range.reverse end
    puts "Iterating over #{iter_range.inspect}"  
    
    r0_ranks = {"00"=>3, "01"=>9, "10"=>2, "11"=>9, "02"=> 9, "20"=>1, "12"=>9, "21"=>9}
    r1_ranks = {"00"=>3, "01"=>2, "10"=>9, "11"=>9, "02"=> 1, "20"=>9, "12"=>9, "21"=>9}
     iter_range.each do |i|
       if(mode == "row")
         left = row
         right = i
       elsif(mode == "col")
         left = i
         right = col
       elsif(mode == "left_diag")
        left = i
        right = i
       else
        left = i
        right = lim - i
       end
       
       
       current_pos = @board.pos_array[left][right]
       player = current_pos.belongs_to
       if(player == 0)
          p0count = p0count + 1
       elsif(player == 1)
          p1count = p1count + 1
       else
          #evaluating  : position> "[#{row}][#{col}] is empty"
       end
      end #loop
      val = "#{p0count}#{p1count}" 
      
      if(player_index == 0)
        player_rank = r0_ranks[val]
      else
        player_rank = r1_ranks[val]
      end
       puts "Exiting evaluate_row() with player_rank = #{player_rank} "
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