jednokrotnie(X, L) :-
    select(X, L, Rest),
    \+ member(X, Rest).

dwukrotnie(X,L):-
    append(Left, [X|Right], L),
    jednokrotnie(X, Right),
    \+ member(X,Left).





