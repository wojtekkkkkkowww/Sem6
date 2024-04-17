
wartosc_oczekiwana(L,E) :-
   sumlist(L,Sum),
   length(L,Len),
   E is  Sum/Len.

wariancja(L,D):-
    length(L,Len),
    wartosc_oczekiwana(L,E),
    wariancja(L,E,0,D1),
    D is D1/Len. %dziele sume przez ilosc

%suma kwadratow odchylen wartosci od E
wariancja([],_,D,D).
wariancja([X|L],E,S,D):-
    NewS is S+(X-E)*(X-E),
    wariancja(L,E,NewS,D).







