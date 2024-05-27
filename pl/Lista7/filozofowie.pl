filozof(Id,Pierwszy, Drugi) :-
    format('[~w] mysli~n', [Id]),
    sleep(0.01),
    format('[~w] chce pierwszy widelec~n',[Id]),
    mutex_lock(Pierwszy),
    format('[~w] podniosl pierwszy widelec~n', [Id]),    
    format('[~w] chce drugi widelec~n', [Id]),
    mutex_lock(Drugi),
    format('[~w] podniosl drugi widelec~n', [Id]),
    format('[~w] je~n', [Id]),
    sleep(0.01),
    mutex_unlock(Pierwszy),
    format('[~w] odlozyl pierwszy widelec~n', [Id]),
    mutex_unlock(Drugi),
    format('[~w] odlozyl drugi widelec~n', [Id]),
    filozof(Id,Pierwszy, Drugi). 

main :-
    mutex_create(F1),
    mutex_create(F2),
    mutex_create(F3),
    mutex_create(F4),
    mutex_create(F5),
    thread_create(filozof(1,F5,F1),_,[detached(true)]),
    thread_create(filozof(2,F2,F1),_,[detached(true)]),
    thread_create(filozof(3,F2,F3),_,[detached(true)]),
    thread_create(filozof(4,F4,F3),_,[detached(true)]),
    thread_create(filozof(5,F4,F5),_,[detached(true)]). 