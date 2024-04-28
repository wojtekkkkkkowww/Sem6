%na stosie trzymam pary (Term,Index)

executeCommand(i, [Current | Rest]) :- 
    [Term,_] = Current,
    Term =.. [_,Child | _],
    !,
    %pierwsze dziecko ma indeks 1
    append([[Child,1]], [Current | Rest], NewStack),
    readCommand(NewStack).

executeCommand(n, [Current, Parent | Rest]) :- 	
    [ParentTerm,_] = Parent,
    [_,CurrentIndex] = Current,
    ParentTerm =.. X, %zamiana termu na liste
    NewIndex is CurrentIndex + 1 ,
    NewIndex > 0,
    nth0(NewIndex , X, Sibling),
    !,
    append([[Sibling,NewIndex]], [Parent | Rest], NewStack),
    readCommand(NewStack).

executeCommand(p, [Current, Parent | Rest]) :- 	
    [ParentTerm,_] = Parent,
    [_,CurrentIndex] = Current,
    ParentTerm =.. X, %zamiana termu na liste
    NewIndex is CurrentIndex - 1 ,
    NewIndex > 0,
    nth0(NewIndex , X, Sibling),
    !,
    append([[Sibling,NewIndex]], [Parent | Rest], NewStack),
    readCommand(NewStack).


executeCommand(o, [_|NewStack]) :- 	
    readCommand(NewStack).

% zawsze mozna zrobic nic poleceniem :)
executeCommand(_, Stack) :- 
    readCommand(Stack).

readCommand([]).
readCommand([H | Rest]) :- 	
    [Term,_] = H,
    writeln(Term),
    write('command: '),
    read(UserCommand),
    executeCommand(UserCommand, [H | Rest]).

browse(Term) :- 
    readCommand([[Term,0]]).