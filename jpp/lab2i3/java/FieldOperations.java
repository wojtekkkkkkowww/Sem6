public interface FieldOperations<T>{
    //operacje arytmetyczne
    T multiply(T a, T b);
    T add(T a, T b);
    T subtract(T a, T b);
    T divide(T a, T b);
    
    T fromInt(int a);

    //operacje porównywania
    boolean equals(T a, T b);
    boolean notEquals(T a, T b);
    boolean greater(T a, T b);
    boolean greaterEquals(T a, T b);
    boolean less(T a, T b);
    boolean lessEquals(T a, T b);
    int getP();

    }