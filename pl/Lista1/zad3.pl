is_prime(2).
is_prime(N) :-
    N > 1,
    N mod 2 =\= 0,
    S is floor(sqrt(N)),
    \+ (between(2, S, X), N mod X =:= 0).

prime(LO, HI, N) :-
    between(LO, HI, N),
    is_prime(N).



