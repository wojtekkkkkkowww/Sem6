#ifndef USER_HPP
#define USER_HPP
#include "DHSetup.hpp"
#include <iostream>
#include <limits>
template <class T>
class User
{
private:
    unsigned long secret;
    T secretKey;
    T publicKey;
    DHSetup<T> setup;

public:
    User(DHSetup<T> &setup)
    {
        std::random_device rd;
        std::mt19937 gen(rd());
        std::uniform_int_distribution<unsigned long> dis(0, std::numeric_limits<unsigned long>::max());
        this->secret = dis(gen);
        this->publicKey = setup.power(setup.getGenerator(), secret);
        this->setup = setup;
    }

    T getPublicKey()
    {
        return publicKey;
    }
    void setKey(T a)
    {
        this->secretKey = this->setup.power(a, secret);
    }
    T encrypt(T m)
    {
        return m * secretKey;
    }
    T decrypt(T c)
    {
        return c / secretKey;
    }
};

#endif // USER_HPP