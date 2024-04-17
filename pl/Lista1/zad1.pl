ojciec(edek,grzes).
ojciec(grzes,wojtek).
ojciec(grzes,piotrek).
ojciec(grzes,kasia).
matka(beata,wojtek).
matka(beata,piotrek).
matka(beata,kasia).
mezczyzna(edek).
mezczyzna(grzes).
mezczyzna(wojtek).
mezczyzna(piotrek).
kobieta(beata).
kobieta(kasia).

czlowiek(Y):-
    mezczyzna(Y);
    kobieta(Y).

rodzic(X,Y) :-
    matka(X,Y);
    ojciec(X,Y).

jest_matka(X) :-
    kobieta(X),matka(X,Y),czlowiek(Y).

jest_ojcem(X):-
    mezczyzna(X),ojciec(X,Y),czlowiek(Y).

jest_synem(X):-
    mezczyzna(X),rodzic(Y,X),czlowiek(Y).

rodzenstwo(X,Y):-
    rodzic(Z,X),rodzic(Z,Y),
    X\=Y.

siostra(X,Y):-
    kobieta(X),rodzenstwo(X,Y).

dziadek(X,Y):-
    mezczyzna(X),ojciec(X,Z),rodzic(Z,Y).



























