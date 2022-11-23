% representation of a directed graph using parent fact
% parent(<parent>, <child>).

parent(pam, bob).
parent(tom, bob).
parent(tom, liz).

parent(bob, anne).
parent(bob, pat).

parent(pat, jim).

% declaring facts of the gender of several of the persons
female(pam).
female(anne).
female(liz).


male(tom).
male(bob).

% sibling rule:
% this is true if X and Y persons are siblings(do they have a parent in common?)
% also checks whether X = Y, as a person cannot be a sibling to themself
sibling(X, Y) :-
    parent(Z, X),
    parent(Z, Y),
    (X \= Y).

% sister rule:
% this is true if X and Y persons are siblings, and if the first person X is female
sister(X, Y) :-
    sibling(X, Y),
    female(X).

% aunt rule:
% this is true if X is an aunt:
% is X a sister? (is X female and have a sibling Y?)
% is sibling Y a parent?
%
aunt(X, Z) :-
    sister(X, Y),
    parent(Y, Z).
