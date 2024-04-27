
% drukowanie : +---+---...
print_divider([]) :-
    write('+'),
    nl.
print_divider([_|T]) :-
    write('+----'),
    print_divider(T).


%drukowanie lini 
print_floor([],_,_) :-
    write('|'),
    nl.

print_floor([K|T],P,N):-
    (K =:= N -> (P =:= 0 -> write('| ## ') ; write('|:##:'));(P =:= 0 -> write('|    ') ; write('|::::'))),
    NewP is 1 - P,
    print_floor(T,NewP,N).




print_row(L,P,N):-
   print_divider(L),
   print_floor(L,P,N),
   print_floor(L,P,N).

% sprawdzanie czy elementy sa z przedzialu 1-N
valid_elements(_, []).
valid_elements(N, [H|T]) :-
    between(1, N, H),
    valid_elements(N, T).



board(X):-
    length(X,N),
    valid_elements(N,X),
    board(N,X,0).


% schodze po weirszach w dol od N do 1
% drukuje wiersz i zmieniam parzystosc P 
board(0,X,_):-
    print_divider(X).

board(N,X,P):-
    N > 0,
    print_row(X,P,N),
    NewP is 1 - P,
    NewN is N-1,
    board(NewN, X , NewP).




% generowanie listy niebijacych hetmanow
hetmany(N,P):-
   numlist(1,N,L),
   perm(L,P),
   dobra(P).

perm([],[]).
perm(L1,[X|L3]):-
    select(X,L1,L2),
    perm(L2,L3).

dobra(X) :-
    \+ zla(X).

zla(X) :-
    append(_,[Wi | L1],X),
    append(L2,[Wj|_],L1),
    length(L2,K),
    abs(Wi - Wj) =:= K + 1.




