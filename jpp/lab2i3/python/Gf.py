class GF:
    p = 1234577

    @staticmethod
    def set_prime(prime):
        GF.p = prime

    @staticmethod
    def get_p():
        return GF.p

    def __init__(self, value):
        self.value = value % GF.p

    def __int__(self):
        return int(self.value)

    def __str__(self):
        return f"GF({self.value})"

    def __extended_euclid(self, a, b):
        if b == 0:
            return 1, 0
        else:
            x, y = self.__extended_euclid(b, a % b)
            return y, x - y * (a // b)

    def inverse(self):
        x, y = self.__extended_euclid(self.value, GF.p)
        return GF((x + self.p) % GF.p)

    def __add__(self, other):
        return GF((self.value + other.value) % GF.p)

    def __sub__(self, other):
        return GF((self.value - other.value) % GF.p)

    def __mul__(self, other):
        return GF((self.value * other.value) % GF.p)

    def __truediv__(self, other):
        if other.value == 0:
            raise ZeroDivisionError
        return self * other.inverse()

    # operatory porównania
    def __eq__(self, other):
        return self.value == other.value

    def __ne__(self, other):
        return self.value != other.value

    def __lt__(self, other):
        return self.value < other.value

    def __le__(self, other):
        return self.value <= other.value

    def __gt__(self, other):
        return self.value > other.value

    def __ge__(self, other):
        return self.value >= other.value
