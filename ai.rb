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
      if(row_positions[i].nil?)
            #Rule
            if(p0count == 0 && p1count == 0 )
              @board.pos_array[row][i].rank0 < 3 ? (puts "Rank unchanged from #{@board.pos_array[row][i].rank0} ") : @board.pos_array[row][i].rank0 = 3 
              @board.pos_array[row][i].rank1 < 3 ? (puts "Rank unchanged from #{@board.pos_array[row][i].rank1} ") : @board.pos_array[row][i].rank1 = 3 
            elsif(p0count == 0 && p1count == 1 )
              @board.pos_array[row][i].rank0 < 9 ? (puts "Rank unchanged from #{@board.pos_array[row][i].rank0} ") : @board.pos_array[row][i].rank0 = 9 
              @board.pos_array[row][i].rank1 < 2 ? (puts "Rank unchanged from #{@board.pos_array[row][i].rank1} ") : @board.pos_array[row][i].rank1 = 2
            elsif(p0count == 1 && p1count == 0 )
              @board.pos_array[row][i].rank0 < 2 ? (puts "Rank unchanged from #{@board.pos_array[row][i].rank0} ") : @board.pos_array[row][i].rank0 = 2 
              @board.pos_array[row][i].rank1 < 9 ? (puts "Rank unchanged from #{@board.pos_array[row][i].rank1} ") : @board.pos_array[row][i].rank1 = 9
            elsif(p0count == 1 && p1count == 1 )
              @board.pos_array[row][i].rank0 < 9 ? (puts "Rank unchanged from #{@board.pos_array[row][i].rank0} ") : @board.pos_array[row][i].rank0 = 9 
              @board.pos_array[row][i].rank1 < 9 ? (puts "Rank unchanged from #{@board.pos_array[row][i].rank1} ") : @board.pos_array[row][i].rank1 = 9
            elsif(p0count == 0 && p1count == 2 )
              @board.pos_array[row][i].rank0 < 9 ? (puts "Rank unchanged from #{@board.pos_array[row][i].rank0} ") : @board.pos_array[row][i].rank0 = 9 
              @board.pos_array[row][i].rank1 == 1 ? (puts "Rank unchanged from #{@board.pos_array[row][i].rank1} ") : @board.pos_array[row][i].rank1 = 1
            elsif(p0count == 2 && p1count == 0 )
              @board.pos_array[row][i].rank0 == 1 ? (puts "Rank unchanged from #{@board.pos_array[row][i].rank0} ") : @board.pos_array[row][i].rank0 = 1 
              @board.pos_array[row][i].rank1 < 9 ? (puts "Rank unchanged from #{@board.pos_array[row][i].rank1} ") : @board.pos_array[row][i].rank1 = 9
            elsif(p0count == 1 && p1count == 2 )
              @board.pos_array[row][i].rank0 < 9 ? (puts "Rank unchanged from #{@board.pos_array[row][i].rank0} ") : @board.pos_array[row][i].rank0 = 9 
              @board.pos_array[row][i].rank1 < 9 ? (puts "Rank unchanged from #{@board.pos_array[row][i].rank1} ") : @board.pos_array[row][i].rank1 = 9
            else
              @board.pos_array[row][i].rank0 < 9 ? (puts "Rank unchanged from #{@board.pos_array[row][i].rank0} ") : @board.pos_array[row][i].rank0 = 9 
              @board.pos_array[row][i].rank1 < 9 ? (puts "Rank unchanged from #{@board.pos_array[row][i].rank1} ") : @board.pos_array[row][i].rank1 = 9
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
     puts "Inside update_col_ranks, = #{col} #{i} "
     if(col_positions[i].nil?)
           #Rule
           if(p0count == 0 && p1count == 0 )
             @board.pos_array[i][col].rank0 < 3 ? (puts "Rank unchanged from #{@board.pos_array[i][col].rank0} ") : @board.pos_array[i][col].rank0 = 3 
             @board.pos_array[i][col].rank1 < 3 ? (puts "Rank unchanged from #{@board.pos_array[i][col].rank1} ") : @board.pos_array[i][col].rank1 = 3 
           elsif(p0count == 0 && p1count == 1 )
             @board.pos_array[i][col].rank0 < 9 ? (puts "Rank unchanged from #{@board.pos_array[i][col].rank0} ") : @board.pos_array[i][col].rank0 = 9 
             @board.pos_array[i][col].rank1 < 2 ? (puts "Rank unchanged from #{@board.pos_array[i][col].rank1} ") : @board.pos_array[i][col].rank1 = 2
           elsif(p0count == 1 && p1count == 0 )
             @board.pos_array[i][col].rank0 < 2 ? (puts "Rank unchanged from #{@board.pos_array[i][col].rank0} ") : @board.pos_array[i][col].rank0 = 2 
             @board.pos_array[i][col].rank1 < 9 ? (puts "Rank unchanged from #{@board.pos_array[i][col].rank1} ") : @board.pos_array[i][col].rank1 = 9
           elsif(p0count == 1 && p1count == 1 )
             @board.pos_array[i][col].rank0 < 9 ? (puts "Rank unchanged from #{@board.pos_array[i][col].rank0} ") : @board.pos_array[i][col].rank0 = 9 
             @board.pos_array[i][col].rank1 < 9 ? (puts "Rank unchanged from #{@board.pos_array[i][col].rank1} ") : @board.pos_array[i][col].rank1 = 9
           elsif(p0count == 0 && p1count == 2 )
             @board.pos_array[i][col].rank0 < 9 ? (puts "Rank unchanged from #{@board.pos_array[i][col].rank0} ") : @board.pos_array[i][col].rank0 = 9 
             @board.pos_array[i][col].rank1 == 1 ? (puts "Rank unchanged from #{@board.pos_array[i][col].rank1} ") : @board.pos_array[i][col].rank1 = 1
           elsif(p0count == 2 && p1count == 0 )
             @board.pos_array[i][col].rank0 == 1 ? (puts "Rank unchanged from #{@board.pos_array[i][col].rank0} ") : @board.pos_array[i][col].rank0 = 1 
             @board.pos_array[i][col].rank1 < 9 ? (puts "Rank unchanged from #{@board.pos_array[i][col].rank1} ") : @board.pos_array[i][col].rank1 = 9
           elsif(p0count == 1 && p1count == 2 )
             @board.pos_array[i][col].rank0 < 9 ? (puts "Rank unchanged from #{@board.pos_array[i][col].rank0} ") : @board.pos_array[i][col].rank0 = 9 
             @board.pos_array[i][col].rank1 < 9 ? (puts "Rank unchanged from #{@board.pos_array[i][col].rank1} ") : @board.pos_array[i][col].rank1 = 9
           else
             @board.pos_array[i][col].rank0 < 9 ? (puts "Rank unchanged from #{@board.pos_array[i][col].rank0} ") : @board.pos_array[i][col].rank0 = 9 
             @board.pos_array[i][col].rank1 < 9 ? (puts "Rank unchanged from #{@board.pos_array[i][col].rank1} ") : @board.pos_array[i][col].rank1 = 9
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
     if(left_diag_positions[i].nil?)
           #Rule
           if(p0count == 0 && p1count == 0 )
             @board.pos_array[i][i].rank0 < 3 ? (puts "Rank unchanged from #{@board.pos_array[i][i].rank0} ") : @board.pos_array[i][i].rank0 = 3 
             @board.pos_array[i][i].rank1 < 3 ? (puts "Rank unchanged from #{@board.pos_array[i][i].rank1} ") : @board.pos_array[i][i].rank1 = 3 
           elsif(p0count == 0 && p1count == 1 )
             @board.pos_array[i][i].rank0 < 9 ? (puts "Rank unchanged from #{@board.pos_array[i][i].rank0} ") : @board.pos_array[i][i].rank0 = 9 
             @board.pos_array[i][i].rank1 < 2 ? (puts "Rank unchanged from #{@board.pos_array[i][i].rank1} ") : @board.pos_array[i][i].rank1 = 2
           elsif(p0count == 1 && p1count == 0 )
             @board.pos_array[i][i].rank0 < 2 ? (puts "Rank unchanged from #{@board.pos_array[i][i].rank0} ") : @board.pos_array[i][i].rank0 = 2 
             @board.pos_array[i][i].rank1 < 9 ? (puts "Rank unchanged from #{@board.pos_array[i][i].rank1} ") : @board.pos_array[i][i].rank1 = 9
           elsif(p0count == 1 && p1count == 1 )
             @board.pos_array[i][i].rank0 < 9 ? (puts "Rank unchanged from #{@board.pos_array[i][i].rank0} ") : @board.pos_array[i][i].rank0 = 9 
             @board.pos_array[i][i].rank1 < 9 ? (puts "Rank unchanged from #{@board.pos_array[i][i].rank1} ") : @board.pos_array[i][i].rank1 = 9
           elsif(p0count == 0 && p1count == 2 )
             @board.pos_array[i][i].rank0 < 9 ? (puts "Rank unchanged from #{@board.pos_array[i][i].rank0} ") : @board.pos_array[i][i].rank0 = 9 
             @board.pos_array[i][i].rank1 == 1 ? (puts "Rank unchanged from #{@board.pos_array[i][i].rank1} ") : @board.pos_array[row][i].rank1 = 1
           elsif(p0count == 2 && p1count == 0 )
             @board.pos_array[i][i].rank0 == 1 ? (puts "Rank unchanged from #{@board.pos_array[i][i].rank0} ") : @board.pos_array[i][i].rank0 = 1 
             @board.pos_array[i][i].rank1 < 9 ? (puts "Rank unchanged from #{@board.pos_array[i][i].rank1} ") : @board.pos_array[i][i].rank1 = 9
           elsif(p0count == 1 && p1count == 2 )
             @board.pos_array[i][i].rank0 < 9 ? (puts "Rank unchanged from #{@board.pos_array[i][i].rank0} ") : @board.pos_array[i][i].rank0 = 9 
             @board.pos_array[i][i].rank1 < 9 ? (puts "Rank unchanged from #{@board.pos_array[i][i].rank1} ") : @board.pos_array[i][i].rank1 = 9
           else
             @board.pos_array[i][i].rank0 < 9 ? (puts "Rank unchanged from #{@board.pos_array[i][i].rank0} ") : @board.pos_array[i][i].rank0 = 9 
             @board.pos_array[i][i].rank1 < 9 ? (puts "Rank unchanged from #{@board.pos_array[i][i].rank1} ") : @board.pos_array[i][i].rank1 = 9
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
       if(right_diag_positions[i].nil?)
             #Rule
             if(p0count == 0 && p1count == 0 )
               @board.pos_array[i][(@board.boardsize - 1)-i].rank0 < 3 ? (puts "Rank unchanged from #{@board.pos_array[i][(@board.boardsize - 1)-i].rank0} ") : @board.pos_array[i][(@board.boardsize - 1)-i].rank0 = 3 
               @board.pos_array[i][(@board.boardsize - 1)-i].rank1 < 3 ? (puts "Rank unchanged from #{@board.pos_array[i][(@board.boardsize - 1)-i].rank1} ") : @board.pos_array[i][(@board.boardsize - 1)-i].rank1 = 3 
             elsif(p0count == 0 && p1count == 1 )
               @board.pos_array[i][(@board.boardsize - 1)-i].rank0 < 9 ? (puts "Rank unchanged from #{@board.pos_array[i][(@board.boardsize - 1)-i].rank0} ") : @board.pos_array[i][(@board.boardsize - 1)-i].rank0 = 9 
               @board.pos_array[i][(@board.boardsize - 1)-i].rank1 < 2 ? (puts "Rank unchanged from #{@board.pos_array[i][(@board.boardsize - 1)-i].rank1} ") : @board.pos_array[i][(@board.boardsize - 1)-i].rank1 = 2
             elsif(p0count == 1 && p1count == 0 )
               @board.pos_array[i][(@board.boardsize - 1)-i].rank0 < 2 ? (puts "Rank unchanged from #{@board.pos_array[i][(@board.boardsize - 1)-i].rank0} ") : @board.pos_array[i][(@board.boardsize - 1)-i].rank0 = 2 
               @board.pos_array[i][(@board.boardsize - 1)-i].rank1 < 9 ? (puts "Rank unchanged from #{@board.pos_array[i][(@board.boardsize - 1)-i].rank1} ") : @board.pos_array[i][(@board.boardsize - 1)-i].rank1 = 9
             elsif(p0count == 1 && p1count == 1 )
               @board.pos_array[i][(@board.boardsize - 1)-i].rank0 < 9 ? (puts "Rank unchanged from #{@board.pos_array[i][(@board.boardsize - 1)-i].rank0} ") : @board.pos_array[i][(@board.boardsize - 1)-i].rank0 = 9 
               @board.pos_array[i][(@board.boardsize - 1)-i].rank1 < 9 ? (puts "Rank unchanged from #{@board.pos_array[i][(@board.boardsize - 1)-i].rank1} ") : @board.pos_array[i][(@board.boardsize - 1)-i].rank1 = 9
             elsif(p0count == 0 && p1count == 2 )
               @board.pos_array[i][(@board.boardsize - 1)-i].rank0 < 9 ? (puts "Rank unchanged from #{@board.pos_array[i][(@board.boardsize - 1)-i].rank0} ") : @board.pos_array[i][(@board.boardsize - 1)-i].rank0 = 9 
               @board.pos_array[i][(@board.boardsize - 1)-i].rank1 == 1 ? (puts "Rank unchanged from #{@board.pos_array[i][(@board.boardsize - 1)-i].rank1} ") : @board.pos_array[i][(@board.boardsize - 1)-i].rank1 = 1
             elsif(p0count == 2 && p1count == 0 )
               @board.pos_array[i][(@board.boardsize - 1)-i].rank0 == 1 ? (puts "Rank unchanged from #{@board.pos_array[i][(@board.boardsize - 1)-i].rank0} ") : @board.pos_array[i][(@board.boardsize - 1)-i].rank0 = 1 
               @board.pos_array[i][(@board.boardsize - 1)-i].rank1 < 9 ? (puts "Rank unchanged from #{@board.pos_array[i][(@board.boardsize - 1)-i].rank1} ") : @board.pos_array[i][(@board.boardsize - 1)-i].rank1 = 9
             elsif(p0count == 1 && p1count == 2 )
               @board.pos_array[i][(@board.boardsize - 1)-i].rank0 < 9 ? (puts "Rank unchanged from #{@board.pos_array[i][(@board.boardsize - 1)-i].rank0} ") : @board.pos_array[i][(@board.boardsize - 1)-i].rank0 = 9 
               @board.pos_array[i][(@board.boardsize - 1)-i].rank1 < 9 ? (puts "Rank unchanged from #{@board.pos_array[i][(@board.boardsize - 1)-i].rank1} ") : @board.pos_array[i][(@board.boardsize - 1)-i].rank1 = 9
             else
               @board.pos_array[i][(@board.boardsize - 1)-i].rank0 < 9 ? (puts "Rank unchanged from #{@board.pos_array[i][(@board.boardsize - 1)-i].rank0} ") : @board.pos_array[i][(@board.boardsize - 1)-i].rank0 = 9 
               @board.pos_array[i][(@board.boardsize - 1)-i].rank1 < 9 ? (puts "Rank unchanged from #{@board.pos_array[i][(@board.boardsize - 1)-i].rank1} ") : @board.pos_array[i][(@board.boardsize - 1)-i].rank1 = 9
             end    
           end
     end #loop
  end
  
  
  
  
 #TO DO--------
 def choose_position()
 
 end
 
 


  
end