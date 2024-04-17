public class GFOperations implements FieldOperations<GF> {
    int p = GF.getP();
    
    public GF multiply(GF a, GF b) {
        return new GF((int)( (long)a.getValue() * (long)b.getValue() % p));
    }

    public GF add(GF a, GF b) {
        return new GF((a.getValue() + b.getValue()) % p);
    }

    public GF subtract(GF a, GF b) {
        return new GF((a.getValue() - b.getValue() + p) % p);
    }

    public GF divide(GF a, GF b) {
        if (b.getValue() == 0) {
            throw new ArithmeticException("Division by zero");
        }
        return multiply(a,b.inverse());
    }

    public boolean equals(GF a, GF b) {
        return a.getValue() == b.getValue();
    }

    public boolean notEquals(GF a, GF b) {
        return a.getValue() != b.getValue();
    }

    public boolean greater(GF a, GF b) {
        return a.getValue() > b.getValue();
    }

    public boolean greaterEquals(GF a, GF b) {
        return a.getValue() >= b.getValue();
    }

    public boolean less(GF a, GF b) {
        return a.getValue() < b.getValue();
    }

    public boolean lessEquals(GF a, GF b) {
        return a.getValue() <= b.getValue();
    }

    public GF fromInt(int a) {
        return new GF(a);
    }

    public int getP() {
        return p;
    }
}