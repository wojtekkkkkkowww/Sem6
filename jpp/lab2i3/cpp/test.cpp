#include "Gf.hpp"
#include <iostream>
int main()
{
    Gf a(10000);
    Gf b(750);
    Gf c = 1234577; // c = 0
    std::cout << "Test konstruktora " << c << std::endl;

    std::cout << "Test drukowania" << std::endl;
    std::cout << a << std::endl
              << std::endl;

    Gf q = 1234576;
    std::cout << "d " << q.inverse() << std::endl;

    if (a * a.inverse() == Gf(1))
    {
        std::cout << "Test inwerse OK\n\n";
    }
    else
    {
        std::cout << "Test inwerse FAILED\n";
    }

    a = c;
    std::cout << "Testy operatorow porownania" << std::endl;
    if (a == c)
    {
        std::cout << "Test == OK\n";
    }
    else
    {
        std::cout << "Test == FAILED\n";
    }

    if (a != b)
    {
        std::cout << "Test != OK\n";
    }
    else
    {
        std::cout << "Test != FAILED\n";
    }

    if (a < b)
    {
        std::cout << "Test < OK\n";
    }
    else
    {
        std::cout << "Test < FAILED\n";
    }

    if (b > a)
    {
        std::cout << "Test > OK\n";
    }
    else
    {
        std::cout << "Test > FAILED\n";
    }

    if (a <= b)
    {
        std::cout << "Test <= OK\n";
    }
    else
    {
        std::cout << "Test <= FAILED\n";
    }

    if (b >= a)
    {
        std::cout << "Test >= OK\n";
    }
    else
    {
        std::cout << "Test >= FAILED\n";
    }

    std::cout << std::endl;
    std::cout << "Testy operatorow arytmetycznych" << std::endl;

    // b = 750
    a = Gf(10000);
    c = a + b;

    if (c == Gf(10750))
    {
        std::cout << "Test + OK\n";
    }
    else
    {
        std::cout << "Test + FAILED\n";
    }

    c = a - b;

    if (c == Gf(9250))
    {
        std::cout << "Test - OK\n";
    }
    else
    {
        std::cout << "Test - FAILED\n";
    }

    a = Gf(1234576);
    b = a * Gf(1234575);

    if (b == Gf(2))
    {
        std::cout << "Test * OK\n";
    }
    else
    {
        std::cout << "Test * FAILED\n";
    }

    c = b / a;

    if (c == b * a.inverse())
    {
        std::cout << "Test / OK\n";
    }
    else
    {
        std::cout << "Test / FAILED\n";
    }

    std::cout << std::endl;
    std::cout << "Testy operatorow przypisania" << std::endl;

    a = Gf(10000);
    b = Gf(750);
    a += b;

    if (a == Gf(10750))
    {
        std::cout << "Test += OK\n";
    }
    else
    {
        std::cout << "Test += FAILED\n";
    }

    a = Gf(10000);
    a -= b;

    if (a == Gf(9250))
    {
        std::cout << "Test -= OK\n";
    }
    else
    {
        std::cout << "Test -= FAILED\n";
    }

    a *= Gf(3);

    if (a == Gf(9250 * 3))
    {
        std::cout << "Test *= OK\n";
    }
    else
    {
        std::cout << "Test *= FAILED\n";
    }

    a = Gf(10000);
    a /= Gf(2);

    if (a == Gf(10000) * Gf(2).inverse())
    {
        std::cout << "Test /= OK\n";
    }
    else
    {
        std::cout << "Test /= FAILED\n";
    }

    std::cout << std::endl;
    std::cout << "Zmiana p na 17" << std::endl;
    Gf::setP(17);
    a = Gf(18);
    std::cout << "a: " << a << std::endl;

    std::cout << std::endl;
    try
    {
        a = Gf(1000) / Gf(0);
    }
    catch (const std::invalid_argument &e)
    {
        std::cout << "Test dzielenia przez 0 OK\n";
    }

    return 0;
}