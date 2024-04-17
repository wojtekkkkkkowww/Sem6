#ifndef GF_HPP
#define GF_HPP

#include <string>
#include <iostream>

class Gf
{

private:
    static int p;
    std::pair<int, int> extendedEuclidean(int a, int b) const
    {
        if (b == 0)
        {
            return {1, 0};
        }
        auto [x, y] = extendedEuclidean(b, a % b);
        return {y, x - (a / b) * y};
    }
    int toField(long val)
    {
        while (val < 0)
        {
            val += p;
        }
        return val % p;
    }

public:
    std::string toString();
    operator int() const;
    friend std::ostream &operator<<(std::ostream &os, const Gf &gf);

    int value;
    Gf(long val) : value(toField(val)) {}
    Gf() : value(toField(0)) {}
    Gf(const Gf &gf) : value(gf.value) {}

    Gf inverse() const
    {
        auto [x, y] = extendedEuclidean(value, p);
        return Gf(x);
    }

    // operatory dzialan
    Gf operator+(const Gf &gf);
    Gf operator-(const Gf &gf);
    Gf operator*(const Gf &gf);
    Gf operator/(const Gf &gf);

    // operatory porownania
    bool operator==(const Gf &gf);
    bool operator!=(const Gf &gf);
    bool operator<(const Gf &gf);
    bool operator>(const Gf &gf);
    bool operator<=(const Gf &gf);
    bool operator>=(const Gf &gf);

    // operatory podsawienia
    Gf &operator=(const Gf &gf);
    Gf &operator+=(const Gf &gf);
    Gf &operator-=(const Gf &gf);
    Gf &operator*=(const Gf &gf);
    Gf &operator/=(const Gf &gf);

    void setVal(int val)
    {
        this->value = val;
    }
    static void setP(int newP)
    {
        p = newP;
    }

    static int getP()
    {
        return p;
    }
};
int Gf::p = 1234577;

Gf::operator int() const
{
    return this->value;
}

std::string Gf::toString()
{
    return std::to_string(this->value);
}

std::ostream &operator<<(std::ostream &os, const Gf &gf)
{
    os << "Gf(" << gf.value << ")";
    return os;
}

Gf Gf::operator+(const Gf &gf)
{
    return Gf(this->value + gf.value);
}

Gf Gf::operator-(const Gf &gf)
{
    return Gf(this->value - gf.value);
}

Gf Gf::operator*(const Gf &gf)
{
    return Gf((long)this->value * (long)gf.value);
}

Gf Gf::operator/(const Gf &gf)
{
    if (gf.value == 0)
    {
        throw std::invalid_argument("Dzielenie przez 0");
    }
    Gf gfInvers = gf.inverse();
    return Gf((long)this->value * (long)gfInvers.value);
}

bool Gf::operator==(const Gf &gf)
{
    return this->value == gf.value;
}

bool Gf::operator!=(const Gf &gf)
{
    return this->value != gf.value;
}

bool Gf::operator<(const Gf &gf)
{
    return this->value < gf.value;
}

bool Gf::operator>(const Gf &gf)
{
    return this->value > gf.value;
}

bool Gf::operator<=(const Gf &gf)
{
    return this->value <= gf.value;
}

bool Gf::operator>=(const Gf &gf)
{
    return this->value >= gf.value;
}

Gf &Gf::operator=(const Gf &gf)
{
    this->value = gf.value;
    return *this;
}

Gf &Gf::operator+=(const Gf &gf)
{
    this->value = toField(this->value + gf.value);
    return *this;
}

Gf &Gf::operator-=(const Gf &gf)
{
    this->value = toField(this->value - gf.value);
    return *this;
}

Gf &Gf::operator*=(const Gf &gf)
{
    this->value = toField((long)this->value * (long)gf.value);
    return *this;
}

Gf &Gf::operator/=(const Gf &gf)
{
    if (gf.value == 0)
    {
        throw std::invalid_argument("Dzielenie przez 0");
    }

    Gf gfInvers = gf.inverse();
    this->value = toField((long)this->value * (long)gfInvers.value);
    return *this;
}

#endif // GF_HPP