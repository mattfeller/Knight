# Knight
Finds a knight's tour on a small board.

User inputs dimensions of the board as space-separated integers. If either dimension is bigger than six, prints "sorry, too hard!" Otherwise, asks user for starting square as another pair of space-separated integers, returning a list of lists of integers describing the sequence of moves for a complete knight's tour. If no tours are possible (including if the specified starting space is not on the board), returns nil.

Note: the code does also work for some inputs with dimensions bigger than 6, including the 8x8 board with starting position (0,0), but only because the algorithm is lucky and finds a solution relatively early in its search.
