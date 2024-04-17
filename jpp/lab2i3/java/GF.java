public class GF implements Field<GF>{
    private static int p = 1234577;
    public static GFOperations operations = new GFOperations();

    private int value;

    private int[] extendedEuclidean(int a, int b) {
        if (a == 0) {
            return new int[]{0, 1};
        } else {
            int[] result = extendedEuclidean(b % a, a);
            int x = result[1] - (b / a) * result[0];
            int y = result[0];
            return new int[]{x, y};
        }
    }

    public GF(int value) {
        this.value = value % p;
    }
    
    public GF inverse() {
        int[] result = extendedEuclidean(this.value, p);
        int x = result[0];
        return new GF((x + p) % p);
    }

    public void assign(GF other) {
        this.value = other.value;
    }

    //operacje arytmetyczne
    public void add(GF other) {
       this.value = (this.value + other.value) % p;
    }
    public void subtract(GF other) {
        this.value = (this.value - other.value + p) % p;
    }

    public void multiply(GF other) {
        this.value = (int)((long)this.value * (long)other.value % p) ;
    }

    public void divide(GF other) {
        if (other.value == 0) {
            throw new ArithmeticException("Division by zero");
        }
        this.multiply(other.inverse());
    }    

    //operatory porównania
    public boolean isValue(int value) {
        return this.value == GF.toField(value);
    }

    //konwersja int do GF
    public static int toField(int value) {
        while (value < 0) {
            value += p;
        }
        return value % p;
    }

    public int getValue() {
        return value;
    }

    public void setValue(int value) {
        this.value = value;
    }

    
    public static void setP(int newP) {
        p = newP;
    }

    public static int getP() {
        return p;
    }

    public String toString() {
        return "GF(" + Integer.toString(value)+ ")";
    }

}
