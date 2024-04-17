import java.util.Random;
import java.util.HashSet;
import java.util.Set;


public class DHSetup<T extends Field,O extends FieldOperations<T>>{
    
    private int p_prev;
    private T generator;
    private O op;
    private Set<Integer> factors;

    private Set<Integer> primeFactors(int n) {
        Set<Integer> factors = new HashSet<>();
        int i = 2;

        while (i * i <= n) {
            if (n % i != 0) {
                i++;
            } else {
                factors.add(i);
                n /= i;
            }
        }

        if (n > 1) {
            factors.add(n);
        }

        return factors;
    }

    public T power(T base,long exponent) {
        T result = op.fromInt(1);
        while (exponent > 0) {
        if (exponent % 2 != 0) {
            result = op.multiply(result,base);
            exponent--;
        }
        base = op.multiply(base,base);
        exponent /= 2;
        }
        return result;
    }

    private boolean isGenerator(T a) {
        for (Integer i : this.factors) {
            if (power(a, this.p_prev / i).getValue() == 1) {
                return false;
            }
        }

        return true;
    }


    public DHSetup(O op) {
        this.op = op;
        this.p_prev = this.op.getP() -1;
        this.factors = primeFactors(this.p_prev);

        Random rand = new Random();
        T a = op.fromInt(rand.nextInt(this.p_prev -1) + 2);
        while (!isGenerator(a)) {
            a = op.fromInt(rand.nextInt(this.p_prev - 1) + 2);
        }
        this.generator = a;
    }

    public T getGenerator() {
        return this.generator;
    }

}