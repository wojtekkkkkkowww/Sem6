% Napisz w SWI-Prologu z wykorzystaniem programowania ograniczeń predykat
% plecak(+Wartości, +Wielkości, +Pojemność, -Zmienne), który dla danej
% listy wartości przedmiotów, listy wielkości przedmiotów i pojemności plecaka,
% rozwiązuje dyskretny problem plecakowy
:- use_module(library(clpfd)).


plecak(Wartosci, Wielkosci, Pojemnosc, Zmienne) :-
    length(Wartosci, N),
    length(Zmienne, N),
    Zmienne ins 0..1,
    scalar_product(Wartosci, Zmienne, #=, Wartosc),
    scalar_product(Wielkosci, Zmienne, #=<, Pojemnosc),
    once(labeling([max(Wartosc)], Zmienne)).