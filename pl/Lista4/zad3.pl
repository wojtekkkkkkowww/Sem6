% Numeruje zapałki liczbami 1 ... 24

policz(F, D, S, M) :-
    polDuze(F, D),
    polSrednie(F, S),
    polMale(F, M).

podzb([], []).
podzb([E|T], [E|NT]):-
    podzb(T, NT).
podzb([_|T], NT):-
    podzb(T, NT).


polDuze(Figury, D) :-
    (subset([1,2,3,4,7,11,14,18,21,22,23,24], Figury) -> D is 1 ; D is 0).

polSrednie(Figury, S) :-
    (subset([1,2,4,6,11,13,15,16], Figury) -> S1 is 1 ; S1 is 0),
    (subset([2,3,5,7,12,14,16,17], Figury) -> S2 is 1 ; S2 is 0),
    (subset([8,9,11,13,18,20,22,23], Figury) -> S3 is 1 ; S3 is 0),
    (subset([9,10,12,14,19,21,23,24], Figury) -> S4 is 1 ; S4 is 0),
    S is S1 + S2 + S3 + S4.


polMale(Figury, M) :-
    (subset([1,4,5,8], Figury) -> M1 is 1 ; M1 is 0),
    (subset([2,5,6,9], Figury) -> M2 is 1 ; M2 is 0),
    (subset([3,6,7,10], Figury) -> M3 is 1 ; M3 is 0),
    (subset([8,11,12,15], Figury) -> M4 is 1 ; M4 is 0),
    (subset([9,12,13,16], Figury) -> M5 is 1 ; M5 is 0),
    (subset([10,13,14,17], Figury) -> M6 is 1 ; M6 is 0),
    (subset([15,18,19,22], Figury) -> M7 is 1 ; M7 is 0),
    (subset([16,19,20,23], Figury) -> M8 is 1 ; M8 is 0),
    (subset([17,20,21,24], Figury) -> M9 is 1 ; M9 is 0),
    M is M1 + M2 + M3 + M4 + M5 + M6 + M7 + M8 + M9.


zabierz(F, K, L) :-
    between(0, 24, K),
    M is 24 - K,
    podzb(F,L),
    length(L,M).


poziome_pietro(F, L) :-
    drukuj_poziomo(F, L),
    write('+'), nl.

drukuj_poziomo(_, []).
drukuj_poziomo(F, [H|T]) :-
    (member(H, F) -> write('+---') ; write('+   ')),
    drukuj_poziomo(F, T).


pionowe_pietro(F, L) :-
    drukuj_pionowo(F, L),
    nl.

drukuj_pionowo(_, []).
drukuj_pionowo(F, [H|T]) :-
    (member(H, F) -> write('|   ') ; write('    ')),
    drukuj_pionowo(F, T).


drukuj(F) :-
    write('Rozwiązanie:'), nl,
    poziome_pietro(F, [1,2,3]),
    pionowe_pietro(F, [4,5,6,7]),
    poziome_pietro(F, [8,9,10]),
    pionowe_pietro(F, [11,12,13,14]),
    poziome_pietro(F, [15,16,17]),
    pionowe_pietro(F, [18,19,20,21]),
    poziome_pietro(F, [22,23,24]).


zapalki(K,D,S,M) :-
    zabierz([1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24], K, L),
    policz(L, D, S, M),
    drukuj(L).
