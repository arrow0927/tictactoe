#!/usr/bin/ruby
class Ai
  
  require_relative 'player'
  require_relative 'game'
  attr_accessor :players, :game
  
  
  
  def initialize(players, game)
    @players = players
    @game = game
    puts "AI.game instance_of #{@game.instance_of?(Game)}"
    puts "AI.game kind_of #{@game.kind_of?(Game)}"
    puts "AI is activated... for contest between #{@players[0].name} and #{@players[1].name}"
  end
  
  #ash's winning_sequences_tracker = {"rows"=>{0=>[[0, 0]], 1=>[], 2=>[]}, 
  #{}"cols"=>{0=>[[0, 0]], 1=>[], 2=>[]}, 
  #{}"left_diag"=>{[0, 0]=>1, [1, 1]=>nil, [2, 2]=>nil}, 
  #{}"right_diag"=>{[2, 0]=>nil, [1, 1]=>nil, [0, 2]=>nil}}
 def choose_position()
  rows_that_need_blocking = get_top_rows(0)
  puts "rows_that_need_blocking for opponent= #{rows_that_need_blocking.inspect}"
  cols_that_need_blocking = get_top_cols(0)
  puts "cols_that_need_blocking for opponent= #{cols_that_need_blocking.inspect}"
  left_diag_that_need_blocking = get_left_diag_pl(0)
  puts "left_diag_that_need_blocking = #{left_diag_that_need_blocking.inspect}"
  right_diag_that_need_blocking = get_right_diag_pl(0)
  puts "right_diag_that_need_blocking = #{right_diag_that_need_blocking.inspect}"
   
  #if there is nothing in the "top" of priority list of any blocking sequence 
  #look in the top priority list of computers winning sequence
   
  rows_that_need_boosting = get_top_rows(1)
  puts "rows_that_need_boosting for computer= #{rows_that_need_boosting.inspect}"
  cols_that_need_boosting = get_top_cols(1)
  puts "cols_that_need_boosting for opponent= #{cols_that_need_boosting.inspect}"
  left_diag_that_need_boosting = get_left_diag_pl(1)
  puts "left_diag_that_need_boosting = #{left_diag_that_need_boosting.inspect}"
  right_diag_that_need_boosting = get_right_diag_pl(1)
  puts "right_diag_that_need_boosting = #{right_diag_that_need_boosting.inspect}"
   
 end
 
 def get_top_rows(ind)
   rows_pl = {"top" => Array.new(), "mid"=>Array.new()}
   row_positions = @game.get_row_occupancy_numbers(ind) #[0,2,1] => index == row#
     row_positions.each_with_index do |val, i|
       if(val == 2)
         rows_pl["top"]  << @players[ind].winning_sequences_tracker["rows"][i]
       end
       if(val == 1)
         rows_pl["mid"]  << @players[ind].winning_sequences_tracker["rows"][i]
       end
     end
     rows_pl
 end
 
 
 
 def get_top_cols(ind)
   cols_pl = {"top" => Array.new(), "mid" =>Array.new()}
   col_positions = @game.get_col_occupancy_numbers(ind) #[0,1,2] => index == column#
    col_positions.each_with_index do |val, i|
       if(val == 2)
         cols_pl["top"]  << @players[ind].winning_sequences_tracker["cols"][i]
       end
       if(val == 1)
         cols_pl["mid"]  << @players[ind].winning_sequences_tracker["cols"][i]
       end
     end
     cols_pl
 end
 
 def get_left_diag_pl(ind)
   left_diag_priority_list = {"top" => Array.new(), "mid"=>Array.new()}
     leftdiag_positions = @game.get_left_diag_occupancy_numbers(ind) #[[0, 0], [1, 1], [2, 2]] => entries in left diag
     if(leftdiag_positions.size() == 2)
       left_diag_priority_list["top"] << leftdiag_positions
     end
     if(leftdiag_positions.size() == 1)
       left_diag_priority_list["mid"] << leftdiag_positions
     end
   left_diag_priority_list
 end
 
 def get_right_diag_pl(ind)
   right_diag_priority_list = {"top" => Array.new(), "mid"=>Array.new()}
     rightdiag_positions = @game.get_right_diag_occupancy_numbers(ind) #[[0, 0], [1, 1], [2, 2]] => entries in left diag
     if(rightdiag_positions.size() == 2)
       right_diag_priority_list["top"] << rightdiag_positions
     end
     if(rightdiag_positions.size() == 1)
       right_diag_priority_list["mid"] << rightdiag_positions
     end
     right_diag_priority_list
 end
 
 
  
end