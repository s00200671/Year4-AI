% Assignment 2
% Ronnie Conlon
%
% X's and O's game using A* search

% representation of the board as a list of facts
%
% representation of the board as a list of lists
%board([[1, 1, n, 1], [1, 2, n, 2], [1, 3, n, 1],
%       [2, 1, n, 2], [2, 2, n, 4], [2, 3, n, 2],
%       [3, 1, n, 1], [3, 2, n, 2], [3, 3, n, 1]]).

% board(<row>, <column>, <x/o or n>, <heuristic value>).

% board
% --------------------------------------------------
cell(1, 1, x, 1). cell(1, 2, n, 2). cell(1, 3, x, 1).
cell(2, 1, n, 2). cell(2, 2, n, 4). cell(2, 3, n, 2).
cell(3, 1, n, 1). cell(3, 2, n, 2). cell(3, 3, o, 1).
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

fullboard(P) :-
    cell(_, _, P, _),
    ((P == x);(P == o)).

% make list of possible moves depending on input
getCells(L, N) :- findall(cell(X, Y, N, H), cell(X, Y, N, H), L).

% check surrounding cells
counterCells(cell(X, Y, _, _), Player, L) :-
    (findall(cell(X, B, Player, Heuristic), cell(X, B, Player, Heuristic), L),
    length(L, 2))
    ;
    (findall(cell(A, Y, Player, Heuristic), cell(A, Y, Player, Heuristic), L),
    length(L, 2)
    )
    ;
    (find




bestPossibleMove(C, Max) :-
    getCells(L, n).

% look for optimal move
optimal_move() :-
    todo().


