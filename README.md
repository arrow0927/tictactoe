Tic Tac Toe - Jan 2013 By Ash Mulekar

For the Player:

The game can be played in 2 modes:
1) Against another player
2) Against a computer

To play the game navigate on the command line to the folder and type "ruby tictactoe_main.rb" to start the game
===============================================================================================================
For developers:
The game contains AI wherein the computer can play against a player and will (always) beat the player. (A free bottle of Maple Syrup to anyone who can beat the computer :)  )

The underlying data structure is an array of arrays. With each element being of type Position. A Position object
contains the coordinates, occupancy, ranks of the players for that position.

The computer internally computes and assigns ranks to each available position. The rank signifies the number of
moves required for either player to complete a winning sequence that includes the position. In this way, after 
each move the AI has a ranking of the available spots are.

The AI's job is then to pick the correct position from all the available spots so as to either itself win or prevent the opponent from winning by blocking their moves.

The way the AI accomplishes this is it extracts a priority list of all open positions from the ranked available positions
such that if the opponent has a winning sequence its blocked or if the AI has a winning sequence its followed. 

Your feedback and comments are welcome. Please send to: amulekar@gmail.com


Thanks,
Ash

