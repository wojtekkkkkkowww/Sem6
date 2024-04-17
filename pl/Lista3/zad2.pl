max_sum(L,S) :-
    max_sum(L,0,0,S).

max_sum([],M,_,M).
max_sum([X|L],M,C,S):-
    (C+X>0 -> C1 is C + X; C1 is 0),
    (C1>M -> M1 is C1;M1 is M),
    max_sum(L,M1,C1,S).





