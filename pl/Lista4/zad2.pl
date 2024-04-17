% tresc zagadki:
%   1 Norweg zamieszkuje pierwszy dom
%   2 Anglik mieszka w czerwonym domu
%   3 Zielony dom znajduje się bezpośrednio po lewej stronie domu białego
%   4 Duńczyk pija herbatkę
%   5 Palacz papierosów light mieszka obok hodowcy kotów
%   6 Mieszkaniec żółtego domu pali cygara
%   7 Niemiec pali fajkę
%   8 Mieszkaniec środkowego domu pija mleko
%   9 Palacz papierosów light ma sąsiada, który pija wodę
%   10 Palacz papierosów bez filtra hoduje ptaki
%   11 Szwed hoduje psy
%   12 Norweg mieszka obok niebieskiego domu
%   13 Hodowca koni mieszka obok żółtego domu
%   14 Palacz mentolowych pija piwo
%   15 W zielonym domu pija się kawę


% dom = [kolor,kto,co_hoduje,co_pije,co_pali]

lewo(X,Y,L) :-
    nextto(X,Y,L).

prawo(X,Y,L) :-
    nextto(Y,X,L).

obok(X,Y,L) :-
    prawo(X,Y,L);lewo(X,Y,L).


zagadka(Domy):-
    length(Domy,5),
    Domy =[dom(_,norweg,_,_,_)|_],
    member(dom(czerowny,anglik,_,_,_),Domy),
    lewo(dom(zielony,_,_,_,_),dom(bialy,_,_,_,_),Domy),
    member(dom(_,dunczyk,_,herbata,_),Domy),
    obok(dom(_,_,_,_,light),dom(_,_,koty,_,_),Domy),
    member(dom(zolty,_,_,_,cygara),Domy),
    member(dom(_,niemiec,_,_,fajki),Domy),
    Domy=[_,_,dom(_,_,_,mleko,_),_,_],
    obok(dom(_,_,_,_,light),dom(_,_,_,woda,_),Domy),
    member(dom(_,_,ptaki,_,bez_filtra),Domy),
    member(dom(_,szwed,psy,_,_),Domy),
    obok(dom(_,norweg,_,_,_),dom(niebieski,_,_,_,_),Domy),
    obok(dom(_,_,konie,_,_),dom(zolty,_,_,_,_),Domy),
    member(dom(_,_,_,piwo,mentolowe),Domy),
    member(dom(zielony,_,_,kawa,_),Domy).


rybki(Kto):-
    zagadka(Domy),
    member(dom(_,Kto,rybki,_,_),Domy).



