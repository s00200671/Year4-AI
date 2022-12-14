% go fish game
%

:- dynamic(hand/2).

hand(player, []).
hand(opponent, []).

cardPile([]).

oppMemory([]).


make_suit(L, S, NL) :-
    append(L, [
        card(S, ace),
        card(S, 1),
                card(S, 2),
                card(S, 3),
                card(S, 4),
                card(S, 5),
                card(S, 6),
                card(S, 7),
                card(S, 8),
                card(S, 9),
                card(S, 10),
                card(S, jack),
                card(S, queen),
                card(S, king)
                ], NL).

make_deck(D) :-
    make_suit(_, heart, L1),
    make_suit(L1, diamond, L2),
    make_suit(L2, club, L3),
    make_suit(L3, spade, D).

randomized_deck(RD) :-
    make_deck(D),
    random_permutation(D, RD).

remove_cards_from_deck(Deck, Size, Cards, NewDeck) :-
    length(Skip, 0),
    append(Skip, Rest, Deck),

    length(Cards, Size),
    append(Cards, NewDeck, Rest).

draw_hand(Deck, Player, Size, NDeck) :-
    remove_cards_from_deck(Deck, Size, Cards, NDeck),
    hand(Player, H),
    append(H, Cards, NewHand),
    retract(hand(Player, H)),
    asserta(hand(Player, NewHand)).

% check matching cards in hand

% ask for a card
askForCard(Card, Cards) :-
    Card =.. [c, s, f],
    hand(player, Hand),
    findall(card(_, f), Hand, Cards).

playerWin(P) :- hand(P, []).

playerTurn(Deck, NewDeck, Cards) :-
    draw_hand(Deck, player, 1, NewDeck),
    hand(player, H),
    write("Your hand is : "),
    writeln(H),
    writeln("Enter a card to ask for"),
    writeln("> "),
    read(X),
    askForCard(X, Cards).

opponentTurn().

setup_game() :-
    randomized_deck(D),
    draw_hand(D, player, 7, ND),
    draw_hand(ND, opponent, 7, NND),
    game_loop(NND).

game_loop(D) :-
    \+ playerWin(player),
    \+ playerWin(opponent),

    playerTurn(D, ND, C),
    opponentTurn().

writec([]).
writec([H|T]) :-
    writeln(H),
    writec(T).

wd() :-
    randomized_deck(D),
    remove_cards_from_deck(D, 5, Cards, NewD).

