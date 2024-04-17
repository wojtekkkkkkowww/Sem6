import java.util.Random;

public class User<T extends Field, O extends FieldOperations<T>> {
    
    private long secret;
    private T secretKey;
    private T publicKey;
    private DHSetup<T, O> setup;
    private O op;

    public User(DHSetup<T, O> setup, O op) {
        this.setup = setup;
        this.op = op;

        Random rand = new Random();
        this.secret = Math.abs(rand.nextLong());
        this.publicKey = setup.power(setup.getGenerator(),secret);
    }

    public T getPublicKey() {
        return publicKey;
    }

    public void setKey(T a) {
        this.secretKey = setup.power(a,secret);
    }

    public T encrypt(T m) {
        
        return op.multiply(m, secretKey);
    }

    public T decrypt(T c) {
        return op.divide(c, secretKey);
    }
}