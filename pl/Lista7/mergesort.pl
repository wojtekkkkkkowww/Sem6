merge(IN1, IN2, OUT) :-
    freeze(IN1, (
        freeze(IN2, (
            (   IN1 = [H1|T1],IN2 = [H2|T2] 
            ->  (   H1 < H2 
                ->  OUT = [H1|OUT1], merge(T1, IN2, OUT1)
                ;   OUT = [H2|OUT2], merge(IN1, T2, OUT2))
            
            ;   (   IN1 = [] 
                ->  OUT = IN2
                ;   OUT = IN1
                )             
            )
        ))
    )).

split(IN,OUT1,OUT2):-
    freeze(IN,
    (   IN = [H|R]
    ->  (   OUT1 = [H|R1],
            split(R,OUT2,R1)
        )

    ;   (
            OUT1 = [],
            OUT2 = []
        )
    )).


mergesort(IN, OUT):-
    freeze(IN,
    (   IN = [H|T]
    ->  (   freeze(T,
            (   T = []
            ->  OUT = [H]
            ;   split(IN, L1, L2),
                mergesort(L1, S1),
                mergesort(L2, S2),
                merge(S1, S2, OUT)
            ))
        )
    ;   OUT = []
    )). 