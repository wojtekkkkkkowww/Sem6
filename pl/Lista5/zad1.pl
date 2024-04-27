scanner(S,Y) :- 
    current_input(I),
    set_input(S),
    read_input(L),
    tokenize(L,[],Y),
    set_input(I).
    
read_input(X) :-
    get_char(C),
    read_next(C,X).

read_next(end_of_file,[]) :-
    !.

read_next(C1,X) :-
    white(C1),
    !,
    get_char(C2),
    read_next(C2,X).

read_next(C1,[H|T]) :-
    read_word(C1,C2,'',H),
    read_next(C2,T).


white(' ').
white('\t').
white('\n').


read_word(end_of_file,end_of_file,N,N) :-
    !.

read_word(C,C,N,N) :-
    white(C),
    !.

read_word(C1,C3,N1,N) :-
    atom_concat(N1,C1,N2),
    get_char(C2),
    read_word(C2,C3,N2,N).


%zamienia liste atomow na liste tokenow
tokenize([], Acc, Acc).

tokenize([H|T], Acc, Result) :-
    atom_chars(H, Chars),
    token_from_chars([], Chars, Tokens),
    append(Acc, Tokens, NewAcc),
    tokenize(T, NewAcc, Result).


%osobno rozpatruje przypadki dla 1 i 2 elementowych separatorow

%kiedy nie przeczytano nic wczesniej dodaje tylko rozpoznany separator
token_from_chars([],[C1,C2|Chars_remaining],[Sep_Token|Tokens]):-
    atom_chars(Sep,[C1,C2]),
    sep(Sep),!,
    token(Sep,Sep_Token),
    token_from_chars([],Chars_remaining,Tokens).

token_from_chars([],[C|Chars_remaining],[Sep_Token|Tokens]):-
    sep(C),!,
    token(C,Sep_Token),
    token_from_chars([],Chars_remaining,Tokens).


token_from_chars(Chars_scanned,[C1,C2|Chars_remaining], [Token,Sep_Token|Tokens]) :-
    atom_chars(Sep,[C1,C2]),
    sep(Sep),!,
    atom_chars(Word,Chars_scanned),
    token(Word,Token),
    token(Sep,Sep_Token),
    token_from_chars([],Chars_remaining,Tokens).

token_from_chars(Chars_scanned,[C|Chars_remaining], [Token,Sep_Token|Tokens]) :-
    sep(C),!,
    atom_chars(Word,Chars_scanned),
    token(Word,Token),
    token(C,Sep_Token),
    token_from_chars([],Chars_remaining,Tokens).
    

%kiedy nie znalazl separatora to dodaje znak i szukam dalej
token_from_chars(Chars_scanned,[C|Chars_remaining], Tokens) :-
    append(Chars_scanned,[C],Chars_scanned_new),
    token_from_chars(Chars_scanned_new,Chars_remaining,Tokens).



% koniec rekurencji
token_from_chars([],[], []) :- !.

token_from_chars(Chars_scanned,[], [Token]) :-
    atom_chars(Word,Chars_scanned),
    token(Word,Token).


token(X,T) :- 
    key(X),
    !,
    T =.. [key,X].
    
token(X,T) :- 
    atom_number(X,N),
    integer(N),
    N >= 0,
    !,
    T =.. [int,N].
    

token(X,T) :-
    sep(X),
    !,
    T =.. [sep,X].

token(X,T) :-
    X \= end_of_file,
    id(X),
    T =.. [id,X].


key(read).
key(write).
key(if).
key(then).
key(else).
key(fi).
key(while).
key(do).
key(od).
key(and).
key(or).
key(mod).

sep(';').
sep('+').
sep('-').
sep('*').
sep('/').
sep('(').
sep(')').
sep('<').
sep('>').
sep('=<').
sep('>=').
sep(':=').
sep('=').
sep('/=').

id(_).