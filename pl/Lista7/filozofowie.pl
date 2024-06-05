filozof(Id,Pierwszy, Drugi,Posilki) :-
    Posilki > 0,
    format('[~w] mysli, posiłek numer ~w~n', [Id, Posilki]),
    sleep(0.01),
    format('[~w] chce pierwszy widelec, posiłek numer ~w~n',[Id, Posilki]),
    mutex_lock(Pierwszy),
    format('[~w] podniosl pierwszy widelec, posiłek numer ~w~n', [Id, Posilki]),    
    format('[~w] chce drugi widelec, posiłek numer ~w~n', [Id, Posilki]),
    mutex_lock(Drugi),
    format('[~w] podniosl drugi widelec, posiłek numer ~w~n', [Id, Posilki]),
    format('[~w] je, posiłek numer ~w~n', [Id, Posilki]),
    sleep(0.01),
    mutex_unlock(Pierwszy),
    format('[~w] odlozyl pierwszy widelec, posiłek numer ~w~n', [Id, Posilki]),
    mutex_unlock(Drugi),
    format('[~w] odlozyl drugi widelec, posiłek numer ~w~n', [Id, Posilki]),
    PozostalePosilki is Posilki - 1,
    filozof(Id,Pierwszy, Drugi,PozostalePosilki).

filozof(Id, _, _, Posilki) :-
    Posilki =< 0,
    format('\e[32mFilozof [~w] skonczyl jesc\e[0m~n',[Id]).

start(P) :-
    mutex_create(F1),
    mutex_create(F2),
    mutex_create(F3),
    mutex_create(F4),
    mutex_create(F5),
    thread_create(filozof(1,F5,F1,P),Id1,[]),
    thread_create(filozof(2,F2,F1,P),Id2,[]),
    thread_create(filozof(3,F2,F3,P),Id3,[]),
    thread_create(filozof(4,F4,F3,P),Id4,[]),
    thread_create(filozof(5,F4,F5,P),Id5,[]),
    thread_join(Id1, _),
    thread_join(Id2, _),
    thread_join(Id3, _),
    thread_join(Id4, _),
    thread_join(Id5, _).