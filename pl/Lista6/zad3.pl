s1 --> [].
s1 --> [a], s1, [b].

counter(N, Char) --> count_chars(Char, 0, N),{!}.
count_chars(_, N, N) --> [].
count_chars(Char, Acc, N) --> [Char], {Acc1 is Acc + 1}, count_chars(Char, Acc1, N).

s2(L) --> {between(0, L, N)}, counter(N, a), counter(N, b), counter(N, c).   

s3(L) --> {between(0, L, N),fib(N, F)}, counter(N, a), counter(F, b).


fib(N, F) :-
    fib(N, [0, 1], F).  % 1 to '-1' element.

fib(0, [F|_], F).
fib(N, [F1, F2|Rest], F) :-
    N > 0,
    F3 is F1 + F2,
    N1 is N - 1,
    fib(N1, [F3, F1, F2|Rest], F).