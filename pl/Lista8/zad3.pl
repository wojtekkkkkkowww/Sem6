:- use_module(library(clpfd)).

odcinek(X) :-
    length(X,16),
    X ins 0..1,
    sum(X, #=, 8),
    append(X1,X2,X),
    X1 ins 0..0,
    chain(X2, #>=).
    