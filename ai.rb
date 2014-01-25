#!/usr/bin/ruby
class Ai
  
  require_relative 'player'
  require_relative 'game'
  require_relative 'board'
    
  attr_accessor :players, :game, :pos_rank_hash
  
  
  #TO DO--------
  def initialize(players, game, board)
    @players = players
    @game = game
    @board = board
    update_board_positions_with_ranks()
    
    puts "AI.game instance_of #{@game.instance_of?(Game)}"
    puts "AI.game kind_of #{@game.kind_of?(Game)}"
    puts "AI is activated... for contest between #{@players[0].name} and #{@players[1].name}"
  end
 #TO DO--------
 # Add a rank to each board position thats not occupied so as to prepare for AI to choose
  def update_board_positions_with_ranks()
    assign_base_ranks()
    assign_opponent_ranks()
    assign_ai_ranks()
    puts "Board positions are now ranked : #{@board.pos_hash.inspect}"
  end
  
 #TO DO--------
 def choose_position()
  update_board_positions_with_ranks()
  @pos_rank_hash = Hash.new()
 

 end
 
 
  #TO DO--------
  def assign_base_ranks()
    @board.pos_hash.each do |pos|
      if(@board.pos_hash[pos]["belongs_to"].nil?) #if none owns it it gets a neutral rank which will be decided later
        @board.pos_hash[pos]["rank0"] = 0
        @board.pos_hash[pos]["rank1"] = 0
      else #if someone owns it there is no rank possible as it can never be occupied
        @board.pos_hash[pos]["rank0"] = nil
        @board.pos_hash[pos]["rank1"] = nil
      end #if/else
    end #loop
  end
  #TO DO--------
  def assign_opponent_ranks()
    @players[0].winning_sequences_tracker.keys.each do |keys|
      
    end
  end
  
  def assign_ai_ranks()
    
  end
  
  
 #TO DO-------- 
 #priority_pos_list example = rows_that_need_blocking for opponent= {"top"=>nil, "mid"=>[[0, 0]]}
 def update_pos_rank_hash(priority_pos_list, winning_seq_type)
   case winning_seq_type
   when "row"
     if(!priority_pos_list["top"].nil?)
       row_number = priority_pos_list["top"][0][0]
       empty_pos = get_empty_pos(row_number , "row")
       if(empty_pos.nil?)
         priority_pos_list["top"]
        end
    end
   when "col"
     
   when "left_diag"
     
   when "right_diag"
   
   else
     
   end
   
 end
 
#TO DO--------
 def get_empty_pos(number, row_or_col)
  avl_positions = Array.new()
  @board.pos_hash.keys.each do |key|
    
  end
 end
 #TO DO--------
 def get_top_rows(ind)
   rows_pl = {"top" => nil, "mid"=>nil}
   row_positions = @game.get_row_occupancy_numbers(ind) #[0,2,1] => index == row#
     row_positions.each_with_index do |val, i|
       if(val == 2)
         rows_pl["top"]  = @players[ind].winning_sequences_tracker["rows"][i]
       end
       if(val == 1)
         rows_pl["mid"]  = @players[ind].winning_sequences_tracker["rows"][i]
       end
     end
     rows_pl
 end
 #TO DO--------
 def check_and_reprioritize_rows(pr_hash)
   if (pr_hash("top").size == 0)
   end
 end
 #TO DO--------
 def get_top_cols(ind)
   cols_pl = {"top" => nil, "mid" =>nil}
   col_positions = @game.get_col_occupancy_numbers(ind) #[0,1,2] => index == column#
    col_positions.each_with_index do |val, i|
       if(val == 2)
         cols_pl["top"]  = @players[ind].winning_sequences_tracker["cols"][i]
       end
       if(val == 1)
         cols_pl["mid"]  = @players[ind].winning_sequences_tracker["cols"][i]
       end
     end
     cols_pl
 end
 #TO DO--------
 def get_left_diag_pl(ind)
   left_diag_priority_list = {"top" => nil, "mid"=>nil}
     leftdiag_positions = @game.get_left_diag_occupancy_numbers(ind) #[[0, 0], [1, 1], [2, 2]] => entries in left diag
     if(leftdiag_positions.size() == 2)
       left_diag_priority_list["top"] = leftdiag_positions
     end
     if(leftdiag_positions.size() == 1)
       left_diag_priority_list["mid"] = leftdiag_positions
     end
   left_diag_priority_list
 end
 #TO DO--------
 def get_right_diag_pl(ind)
   right_diag_priority_list = {"top" => nil, "mid"=>nil}
     rightdiag_positions = @game.get_right_diag_occupancy_numbers(ind) #[[0, 0], [1, 1], [2, 2]] => entries in left diag
     if(rightdiag_positions.size() == 2)
       right_diag_priority_list["top"] = rightdiag_positions
     end
     if(rightdiag_positions.size() == 1)
       right_diag_priority_list["mid"] = rightdiag_positions
     end
     right_diag_priority_list
 end
 
 
  
end