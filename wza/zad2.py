from abc import ABC, abstractmethod

class PolyInterface(ABC):
    @abstractmethod
    def getOne(self):
        pass

    @abstractmethod
    def getZero(self):
        pass

    def __add__(self, other):
        return self.add(other)

    def __sub__(self, other):
        return self.sub(other)

    def __mul__(self, other):
        return self.mul(other)

    def __floordiv__(self, other):
        return self.div(other)

    def __eq__(self, other):
        return self.eq(other)

   
    @abstractmethod
    def add(self, other):
        pass

    @abstractmethod
    def sub(self, other):
        pass

    @abstractmethod
    def mul(self, other):
        pass

    @abstractmethod
    def div(self, other):
        pass

    @abstractmethod
    def eq(self, other):
        pass

   


def resize(x,y):
        dif = len(x) - len(y)
        if dif > 0:
            y = y + [0 for i in range(dif)]
        else :
            x = x + [0 for i in range(-dif)]
        
        return (x,y)

class polynomial(PolyInterface):
       
    def __init__(self,coefficients):
        while len(coefficients) > 1 and coefficients[-1] == 0:
            coefficients.pop()
        self.coefficients = coefficients
    
    def degree(self):
        return len(self.coefficients) - 1
    
    def __str__(self):
        return " + ".join([str(self.coefficients[i]) + "x^" + str(i) for i in range(len(self.coefficients))])
    
    def add(self, other):
        x,y = resize(self.coefficients,other.coefficients)
        return polynomial([x[i] + y[i] for i in range(len(x))])
        
    def sub(self, other):
        x,y = resize(self.coefficients,other.coefficients)
        return polynomial([x[i] - y[i] for i in range(len(x))])
   
    def mul(self, other):
        result = [0 for i in range(len(self.coefficients) + len(other.coefficients) - 1)]
        for i in range(len(self.coefficients)):
            for j in range(len(other.coefficients)):
                result[i+j] += self.coefficients[i] * other.coefficients[j]
        return polynomial(result)
    
    def div(self, other):
        if other.coefficients == [0]:
            raise ValueError("Division by zero")
        
        q = polynomial([0])
        p = self
        
        while p.degree() >= other.degree() and p != polynomial([0]):
            a = p.coefficients[-1] / other.coefficients[-1]
            deg = p.degree() - other.degree()
            a = polynomial([0 for i in range(deg)] + [a])
            
            q += a
            p -= a * other

        r = p
        return (q, r)
    
    def eq(self, other):
        return self.coefficients == other.coefficients

    def getOne(self):
        return polynomial([1])
    
    def getZero(self):
        return polynomial([0])



def gcd(x:PolyInterface, y:PolyInterface):
        if y == y.getZero():
            return x
        q,r = x//y
        return gcd(y, r)    

def lcm(x:PolyInterface,y:PolyInterface):
    q,r = (x*y)//gcd(x,y)
    return q    


# nwd(a,b) = d = a*s + b*t
def extended_gcd(a: PolyInterface, b: PolyInterface):
    if b == b.getZero():
        return (a, a.getOne(), b.getZero())
    q, r = a // b
    d, s, t = extended_gcd(b, r)
    return (d, t, s - q * t)



if __name__ == "__main__":

    p1 = polynomial([-2,-1,6])
    p2 = polynomial([1,2])
    q,r = p1//p2
    print(f"p1 = {p1}")
    print(f"p2 = {p2}")
    if p1 == p2*q + r:
        print("test passed")
        print(f"q = {q}")
        print(f"r = {r}")
    else:
        print("test failed")    
    print( )

        

    a = polynomial([1,0,1])
    b = polynomial([1,2,1])
    print(f"c = {gcd(a,b)}")
    print(f"d = {lcm(a,b)}")

    print( )
    print("Lab 8")
    print("Extended gcd test")
    a = polynomial([1,0,1])
    b = polynomial([1,2,1])
    d,s,t = extended_gcd(a,b)
    if d == a*s + b*t:
        print("test passed")
        print(f"d = {d}")
        print(f"s = {s}")
        print(f"t = {t}")