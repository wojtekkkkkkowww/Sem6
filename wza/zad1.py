class GaussInt:
    def __init__(self, a, b):
        self.a = a
        self.b = b

    def norm(self):
        return self.a*self.a + self.b*self.b
    
    def __str__(self):
        return f"{self.a} + {self.b}i"

    def __add__(self, other):
        return GaussInt(self.a + other.a, self.b + other.b)

    def __sub__(self, other):
        return GaussInt(self.a - other.a, self.b - other.b)
    
    def __mul__(self, other):
        return GaussInt(self.a * other.a - self.b * other.b, self.a * other.b + self.b * other.a)
    
    def __truediv__(self, other):
        if other.a == 0 and other.b == 0:
            return []
        norm = other.norm()
        a = (self.a*other.a + self.b*other.b)/norm
        b = (self.b*other.a - self.a*other.b)/norm
        q = GaussInt(round(a),round(b))
        return (q, self - (q * other))

def gcd(x, y):
    if y.a == 0 and y.b == 0:
        return x
    q,r = x/y
    return gcd(y, r)    

def lcm(x,y):
    q,r = (x*y)/gcd(x,y)
    return q
    
# test
x = GaussInt(3,4)
y = GaussInt(1,3)

print(f"c = {gcd(x,y)}")
print(f"d = {lcm(x,y)}")
