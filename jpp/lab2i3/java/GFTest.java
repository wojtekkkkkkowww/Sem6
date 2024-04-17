public class  GFTest  {
    public static void main(String[] args) {
        // Test add method
        GF a = new GF(10000);
        GF b = new GF(750);
        GF c = new GF(1234577);
        System.out.println("Test drukowania");
        System.out.println(a);

        if(GF.operations.multiply(a,a.inverse()).isValue(1)){
            System.out.println("Test inverse OK");
        }else{
            System.out.println("Test inverse failed");
        }

        System.out.println();
        System.out.println("Testy operatorow porownania");
        
        a.assign(c);
        if(GF.operations.equals(a,c)){
            System.out.println("Test == OK");
        }else{
            System.out.println("Test == failed");
        }

        if(GF.operations.notEquals(a,b)){
            System.out.println("Test != OK");
        }else{  
            System.out.println("Test != failed");
        }

        if(GF.operations.less(a,b)){
            System.out.println("Test < OK");
        }else{
            System.out.println("Test < failed");
        }

        if(GF.operations.greater(b,a)){
            System.out.println("Test > OK");
        }else{
            System.out.println("Test > failed");
        }

        if(GF.operations.lessEquals(a,b)){
            System.out.println("Test <= OK");
        }else{
            System.out.println("Test <= failed");
        }

        if(GF.operations.greaterEquals(b,a)){
            System.out.println("Test >= OK");
        }else{
            System.out.println("Test >= failed");
        }

        System.out.println();
        System.out.println("Testy operatorow arytmetycznych");

        a.setValue(10000);
        c = GF.operations.add(a,b);
        if(c.isValue(10000+750)){
            System.out.println("Test + OK");
        }else{
            System.out.println("Test + failed");
        }

        c = GF.operations.subtract(a,b);
        if(c.isValue(10000-750)){
            System.out.println("Test - OK");
        }else{
            System.out.println("Test - failed");
        }    

        a.setValue(1234576);
        c.setValue(1234575);
        b = GF.operations.multiply(a,c);
        if(b.isValue(2)){
            System.out.println("Test * OK");
        }else{
            System.out.println("Test * failed");
        }

        c = GF.operations.divide(a,b);
        if(GF.operations.equals(c,GF.operations.multiply(a,b.inverse()))){
            System.out.println("Test / OK");    
        }else{
            System.out.println("Test / failed");
        }

        System.out.println();
        System.out.println("Testy przypisania");

        a.setValue(10000);
        b.setValue(750);
        a.add(b);
        if(a.isValue(10750)){
            System.out.println("Test += OK");
        }else{
            System.out.println("Test += failed");
        }

        a.setValue(10000);
        a.subtract(b);
        if(a.isValue(9250)){
            System.out.println("Test -= OK");
        }else{
            System.out.println("Test -= failed");
        }
        
        b.setValue(3);
        a.multiply(b);
        if(a.isValue(9250*3)){
            System.out.println("Test *= OK");
        }else{
            System.out.println("Test *= failed");
        }

        a.setValue(10000);
        b.setValue(2);
        a.divide(b);
        c = new GF(10000);
        b = GF.operations.multiply(b.inverse(),c);

        if(GF.operations.equals(a,b)){
            System.out.println("Test /= OK");
        }else{
            System.out.println("Test /= failed");
        }

        System.out.println();
        System.out.println("Zamiana p na 17");

        GF.setP(17);
        a = new GF(18);

        System.out.println(a);
        System.out.println();

        b = new GF(0);
        try {
            a.divide(b);
        } catch (ArithmeticException e) {
            System.out.println("Test dzielenia przez zero OK");
        }
        
    }
}