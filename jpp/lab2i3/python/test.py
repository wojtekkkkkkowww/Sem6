from Gf import GF

class test:
    value = 30000000 

def main():
    
    a = GF(10000)
    b = GF(750)
    c = GF(1234577)  # c = 0
    t = test()
    q = t * a  
    print("fsf" + str(q))
    print("Test drukowania")
    print(a, "\n")

    if a * a.inverse() == GF(1):
        print("Test inwerse OK\n")
    else:
        print("Test inwersji FAILED\n")

    a = c
    print("Testy operatorow porownania")
    if a == c:
        print("Test == OK\n")
    else:
        print("Test == FAILED\n")

    if a != b:
        print("Test != OK\n")
    else:
        print("Test != FAILED\n")

    if a < b:
        print("Test < OK\n")
    else:
        print("Test < FAILED\n")

    if b > a:
        print("Test > OK\n")
    else:
        print("Test > FAILED\n")

    if a <= b:
        print("Test <= OK\n")
    else:
        print("Test <= FAILED\n")

    if b >= a:
        print("Test >= OK\n")
    else:
        print("Test >= FAILED\n")

    print("\nTesty operatorow arytmetycznych")

    # b = 750
    a = GF(10000)
    c = a + b

    if c == GF(10750):
        print("Test + OK\n")
    else:
        print("Test + FAILED\n")

    c = a - b

    if c == GF(9250):
        print("Test - OK\n")
    else:
        print("Test - FAILED\n")

    a = GF(1234576)
    b = a * GF(1234575)

    if b == GF(2):
        print("Test * OK\n")
    else:
        print("Test * FAILED\n")

    c = b / a
    if c == b * a.inverse():
        print("Test / OK\n")
    else:
        print("Test / FAILED\n")

    print("\nTesty operatorow przypisania")

    a = GF(10000)
    b = GF(750)
    a += b

    if a == GF(10750):
        print("Test += OK\n")
    else:
        print("Test += FAILED\n")

    a = GF(10000)
    a -= b

    if a == GF(9250):
        print("Test -= OK\n")
    else:
        print("Test -= FAILED\n")

    a *= GF(3)

    if a == GF(9250 * 3):
        print("Test *= OK\n")
    else:
        print("Test *= FAILED\n")

    a = GF(10000)
    a /= GF(2)

    if a == GF(10000) * GF(2).inverse():
        print("Test /= OK\n")
    else:
        print("Test /= FAILED\n")

    print("\nZmiana p na 17")
    GF.set_prime(17)
    a = GF(18)
    print("a: ", a)

    print("\nTest dzielenia przez 0")
    try:
        a = GF(1000) / GF(0)
    except ZeroDivisionError:
        print("Caught division by zero")


if __name__ == "__main__":
    main()
