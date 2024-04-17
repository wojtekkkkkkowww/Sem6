import random

class DHSetup:
    def __init__(self, T):
        self.T = T
        self.generator = T(random.randint(1, T.get_p() - 1))
        while not self.__is_generator(self.generator):
            self.generator = T(random.randint(1, T.get_p() - 1))

    def power(self, base, exponent):
        result = self.T(1)
        while exponent > 0:
            if exponent % 2 == 1:
                result *= base
            base *= base
            exponent //= 2
        return result

    def __prime_factors(self, n):
        i = 2
        factors = set()
        while i * i <= n:
            if n % i:
                i += 1
            else:
                n //= i
                factors.add(i)
        if n > 1:
            factors.add(n)
        return factors

    def __is_generator(self, a):
        p_prev = self.T.get_p() - 1
        primes = self.__prime_factors(p_prev)
        for factor in primes:
            if int(self.power(a, p_prev // factor)) == 1:
                return False
        return True

class User:
    def __init__(self, setup):
        self.setup = setup
        self.secret = random.randint(1, setup.T.get_p() - 1)
        self.public_key = setup.power(setup.generator, self.secret)

    def get_public_key(self):
        return self.public_key

    def set_key(self, a):
        self.__secret_key = self.setup.power(a, self.secret)

    def encrypt(self, m):
        return m * self.__secret_key

    def decrypt(self, c):
        return c / self.__secret_key
    

if __name__ == "__main__":
    from Gf import GF
    GF.set_prime(1234567891)
    setup = DHSetup(GF)
    alice = User(setup)
    bob = User(setup)

    print("Alice's public key:", alice.get_public_key())
    print("Bob's public key:", bob.get_public_key())

    alice.set_key(bob.get_public_key())
    bob.set_key(alice.get_public_key())

    message = GF(123456)
    encrypted = alice.encrypt(message)
    decrypted = bob.decrypt(encrypted)

    print("Message:", message)
    print("Encrypted:", encrypted)
    print("Decrypted:", decrypted)

    message = GF(456461)
    encrypted = alice.encrypt(message)
    decrypted = bob.decrypt(encrypted)

    print("Message:", message)
    print("Encrypted:", encrypted)
    print("Decrypted:", decrypted)