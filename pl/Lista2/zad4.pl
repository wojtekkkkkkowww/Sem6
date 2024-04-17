prawo(X, L) :-
    Min is X - 1,
    Max is 2 * (X - 1),
    between(Min,Max,I0),


    nth0(I0, L, X),
    nth0(I1, L, X),
    I0 < I1,
    (I1 - I0) mod 2 =:= 1.

po_prawej(1,L):-
    prawo(1,L).

po_prawej(N, L) :-
    M is N - 1,
    prawo(N, L),
    po_prawej(M, L).

lista(N, [1|T]) :-
    M is N * 2,
    length([1|T], M),
    po_prawej(N, [1|T]).












