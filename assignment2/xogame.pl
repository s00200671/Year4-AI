% Assignment 2
% Ronnie Conlon
%
% X's and O's game using A* search

% board
% --------------------------------------------------
:- dynamic cell/4.

cell(1, 1, x, 1). cell(1, 2, n, 2). cell(1, 3, x, 1).
cell(2, 1, n, 2). cell(2, 2, o, 4). cell(2, 3, n, 2).
cell(3, 1, o, 1). cell(3, 2, o, 2). cell(3, 3, n, 1).
% --------------------------------------------------

% terminal states for the board

% 3 in a row for row
win(P) :-
    cell(Z, 1, P, _),
    cell(Z, 2, P, _),
    cell(Z, 3, P, _).


% 3 in a row for column
win(P) :-
    cell(1, Z, P, _),
    cell(2, Z, P, _),
    cell(3, Z, P, _).

% 3 in a row diagonal
win(P) :-
    (   cell(1, 1, P, _),
        cell(2, 2, P, _),
        cell(3, 3, P, _))
    ;
    (   cell(1, 3, P, _),
        cell(2, 2, P, _),
        cell(3, 1, P, _)).

% full board

boardNotFull(P) :-
    cell(_, _, P, _),
    P = n.

% make list of possible moves depending on input
getCells(L, N) :- findall(cell(X, Y, N, H), cell(X, Y, N, H), L).

% Get almost wins (2 out of 3 for a win condition)
% this checks rows and columns based off of given cell by finding all of a certain players inputs
% using surrounding cells
% then checks what the length of the list is
% is the list is 2 then clearly the player/opponent has 2 out of 3, meaning the empty cell
% is a counter cell
counterCell(cell(X, Y, N, H), Player) :-
    ((   findall(cell(X, B, Player, Heuristic), cell(X, B, Player, Heuristic), L),
    length(L, 2))
    ;
    (findall(cell(A, Y, Player, Heuristic), cell(A, Y, Player, Heuristic), L),
    length(L, 2))),
    assertz(cell(X, Y, N, 5)),
    retract(cell(X, Y, N, H)).

winCell(cell(X, Y, N, H), Player) :-
    (    
    (findall(cell(X, B, Player, Heuristic), cell(X, B, Player, Heuristic), L),
    length(L, 2))
    ;
    (findall(cell(A, Y, Player, Heuristic), cell(A, Y, Player, Heuristic), L),
    length(L, 2))
    ),
    assertz(cell(X, Y, N, 10)),
    retract(cell(X, Y, N, H)).

% look for optimal move
optimal_move(WinningCells, CounterCells, OptimalMove) :-
    %check if board is valid, anyone won yet?
    %\+ win(_),
    %check if board is full if no one has won
    %\+ fullboard(_),
    %check free spaces
    getCells(L, n),
    writeln(L),
    %using free spaces, check win spaces
    %maplist((member(Cell, L), winCell(Cell, x)), L, WinningCells),
    maplist(winCell(), L, WinningCells),
    getCells(M, n),
    %if no win spaces, check counter spaces
    findall(Cell, (member(Cell, M), counterCell(Cell, o)), CounterCells),
    getCells(N, n),
    writeln(N),
    %if no counter spaces, choose highest heuristic val
    write("Winning Move(s): "),
    writeln(WinningCells),
    
    write("Counter Moves(s): "),
    writeln(CounterCells),
    
    write("Moves in order of heuristic val: "),
    
    OptimalMove = [WinningCells, CounterCells, L].
    
