#ifndef DHSETUP_HPP
#define DHSETUP_HPP

#include <random>
#include <limits>
#include <unordered_set>

template <class T>
class DHSetup
{
private:
    int p_prev;
    T generator;
    std::unordered_set<int> factors;

    std::unordered_set<int> prime_factors(int n)
    {
        std::unordered_set<int> factors;
        int i = 2;

        while (i * i <= n)
        {
            if (n % i != 0)
            {
                i++;
            }
            else
            {
                factors.insert(i);
                n /= i;
            }
        }

        if (n > 1)
        {
            factors.insert(n);
        }

        return factors;
    }

    bool is_generator(T a)
    {
        for (int i : this->factors)
        {
            if ((int)power(a, this->p_prev / i) == 1)
            {
                return false;
            }
        }
        return true;
    }

public:
    DHSetup()
    {
        this->p_prev = (int)T(-1);

        std::random_device rd;
        std::mt19937 rng(rd());
        std::uniform_int_distribution<int> uni(0, this->p_prev);

        T a = T(uni(rng));
        this->factors = prime_factors(this->p_prev - 1);
        while (!is_generator(a))
        {
            a = uni(rng);
        }
        this->generator = a;
    }

    T getGenerator()
    {
        return this->generator;
    }

    T power(T a, unsigned long b)
    {
        T result = 1;
        while (b)
        {
            if (b & 1)
                result *= a;
            b >>= 1;
            a *= a;
        }
        return result;
    }
};

#endif