public class DHTest {
    public static void main(String[] args) {
        GF.setP(1234567891);
        FieldOperations<GF> op = new GFOperations(); 
        DHSetup<GF, FieldOperations<GF>> setup = new DHSetup<>(op);

        User<GF, FieldOperations<GF>> alice = new User<>(setup,op);
        User<GF, FieldOperations<GF>> bob = new User<>(setup,op);
        System.out.println("Alice's public key: " + alice.getPublicKey());
        System.out.println("Bob's public key: " + bob.getPublicKey());

        alice.setKey(bob.getPublicKey());
        bob.setKey(alice.getPublicKey());

       
        GF message = new GF(123456);
        GF encrypted = alice.encrypt(message);
        GF decrypted = bob.decrypt(encrypted);

       
        System.out.println("Message: " + message);
        System.out.println("Encrypted: " + encrypted);
        
        System.out.println("Decrypted: " + decrypted);
        
        message = new GF(456461);
        encrypted = alice.encrypt(message);
        decrypted = bob.decrypt(encrypted);

        
        System.out.println("Message: " + message);
        System.out.println("Encrypted: " + encrypted);
        System.out.println("Decrypted: " + decrypted);
        
    }
}