wyrazenie([N], N).

wyrazenie(L, E) :-
    append(L1, L2, L),
    L1 \= [], L2 \= [],
    wyrazenie(L1, E1),
    wyrazenie(L2, E2),
    member(Op, [+,-,*]),
    E =.. [Op, E1, E2].

wyrazenie(L, X, E) :-
    wyrazenie(L, E),
    X is E.


