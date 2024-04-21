%na stosie trzymam pary (Term,Index)


executeCommand(i, [Current | Rest]) :- 
    nth0(0,Current,Term),
    Term =.. [_ | [Child | _]],
    %pierwsze dziecko ma indeks 1
    append([[Child,1]], [Current | Rest], NewStack),
    readCommand(NewStack).


executeCommand(n, [Current, Parent | Rest]) :- 	
    nth0(0, Parent, ParentTerm),
    nth0(1,Current, CurrentIndex),
    ParentTerm =.. X,
    length(X, ParentLength),
    NewIndex is CurrentIndex + 1 ,
    between(1, ParentLength, NewIndex),
    nth0(NewIndex , X, Sibling),
    append([[Sibling,NewIndex]], [Parent | Rest], NewStack),
    readCommand(NewStack).

executeCommand(p, [Current, Parent | Rest]) :- 	
    nth0(0, Parent, ParentTerm),
    nth0(1,Current, CurrentIndex),
    ParentTerm =.. X,
    length(X, ParentLength),
    NewIndex is CurrentIndex - 1 ,
    between(1, ParentLength, NewIndex),
    nth0(NewIndex , X, Sibling),
    append([[Sibling,NewIndex]], [Parent | Rest], NewStack),
    readCommand(NewStack).

% wyjscie z programu 
executeCommand(o, [ _ ]).

executeCommand(o, [_, Parent | Rest]) :- 	
    nth0(0, Parent, ParentTerm),
    nth0(1, Parent, ParentIndex),
    append([[ParentTerm,ParentIndex]], Rest, NewStack),
    readCommand(NewStack).

% zawsze mozna zrobic nic poleceniem :)
executeCommand(_, Stack) :- 
    readCommand(Stack).

readCommand([]).
readCommand([H | Rest]) :- 	
    writeln(H),
    write('command: '),
    read(UserCommand),
    executeCommand(UserCommand, [H | Rest]).

browse(Term) :- 
    readCommand([[Term,0]]).