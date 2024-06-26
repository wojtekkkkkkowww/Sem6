even_permutation([],[]).
even_permutation([X|R],L) :-
    even_permutation(R,Z),
    add_odd(Z,X,L).
even_permutation([X|R],L) :-
    odd_permutation(R,Z),
    add_even(Z,X,L).


odd_permutation([X|R],L) :-
    odd_permutation(R,Z),
    add_odd(Z,X,L).
odd_permutation([X|R],L) :-
    even_permutation(R,Z),
    add_even(Z,X,L).


add_odd(L,X,[X|L]).
add_odd([A,B|L],X,[A,B|Y]) :-
    add_odd(L,X,Y).

add_even([Q|L],X,[Q|Y]) :-
    add_odd(L,X,Y).































