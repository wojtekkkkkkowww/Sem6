%drukowane planszy z hetmanami w prolog

drukuj_rozdzielacz([]) :-
    write('+'),
    nl.
drukuj_rozdzielacz([_|T]) :-
    write('+----'),
    drukuj_rozdzielacz(T).

% schodze po weirszach w dol od N do 1
% w kazdym z weirszy drukuje 4 'pieterka'
% znam numer wiersza
% przechodze przez kolumny tam gdzie sie zgadza bede drukowal hetmany
% mozna zaczac od wydrukwoania pustej planszy
% drukowanie hetmanow to beda tylko dodatkowe ify

%musze przekazac informacje o parzystosci / nieparzystosci

%drukuj wiersz musi znac numer wiersza
% no i ta liste
drukuj_pietro([],_,_) :-
    write('|'),
    nl.


drukuj_pietro([K|T],P,N):-
    (K =:= N -> (P =:= 0 -> write('| ## ') ; write('|:##:'));(P =:= 0 -> write('|    ') ; write('|::::'))),
    NewP is 1 - P,
    drukuj_pietro(T,NewP,N).

drukuj_wiersz(L,P,N):-
   drukuj_rozdzielacz(L),
   drukuj_pietro(L,P,N),
   drukuj_pietro(L,P,N).


valid_elements(_, []).
valid_elements(N, [H|T]) :-
    between(1, N, H),
    valid_elements(N, T).

board(X):-
    length(X,N),
    valid_elements(N,X),
    board(N,X,0).



board(0,X,_):-
    drukuj_rozdzielacz(X).

board(N,X,P):-
    N > 0,
    drukuj_wiersz(X,P,N),
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




