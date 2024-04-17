public interface Field<T>{
    void add(T other);
    void subtract(T other);
    void multiply(T other);
    void divide(T other);
    int getValue();
    T inverse(); 
}