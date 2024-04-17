#include "User.hpp"
#include "DHSetup.hpp"
#include "Gf.hpp"
int main()
{
    Gf::setP(1234567891);
    DHSetup<Gf> setup;
    User<Gf> alice(setup);
    User<Gf> bob(setup);

    std::cout << "Alice's public key: " << alice.getPublicKey() << std::endl;
    std::cout << "Bob's public key: " << bob.getPublicKey() << std::endl;

    alice.setKey(bob.getPublicKey());
    bob.setKey(alice.getPublicKey());

    Gf message = 123456;
    Gf encrypted = alice.encrypt(message);
    Gf decrypted = bob.decrypt(encrypted);

    std::cout << "Message: " << message << std::endl;
    std::cout << "Encrypted: " << encrypted << std::endl;
    std::cout << "Decrypted: " << decrypted << std::endl;

    message = 456461;
    encrypted = alice.encrypt(message);
    decrypted = bob.decrypt(encrypted);

    std::cout << "Message: " << message << std::endl;
    std::cout << "Encrypted: " << encrypted << std::endl;
    std::cout << "Decrypted: " << decrypted << std::endl;

    return 0;
}