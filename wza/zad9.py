import numpy as np
import matplotlib.pyplot as plt

# Definiowanie siatki wartości x i y
x = np.linspace(-10, 10, 400)
y = np.linspace(-10, 10, 400)
X, Y = np.meshgrid(x, y)

# 1. (x^2 + y^2 + 4y)^2 - 16(x^2 + y^2) = 0
# Obliczanie wartości równania dla każdej pary (x, y)
Z = (X**2 + Y**2 + 4*Y)**2 - 16*(X**2 + Y**2)

plt.figure(figsize=(8, 8))
plt.contour(X, Y, Z, levels=[0], colors='blue')
plt.xlabel('x')
plt.ylabel('y')
plt.title('(x^2 + y^2 + 4y)^2 - 16(x^2 + y^2) = 0')
plt.axhline(0, color='black',linewidth=0.5)
plt.axvline(0, color='black',linewidth=0.5)
# punkt osobliwe
plt.plot(0, 0, 'ro')

plt.savefig('z9.1.png')

plt.clf()

#2. 2(x^2 + 9)(y^2 − 16) + (x^2 − 9)^2 + (y^2 − 16)^2 = 0
Z = 2*(X**2 + 9)*(Y**2 - 16) + (X**2 - 9)**2 + (Y**2 - 16)**2

plt.figure(figsize=(8, 8))
plt.contour(X, Y, Z, levels=[0], colors='blue')
plt.xlabel('x')
plt.ylabel('y')
plt.title('2(x^2 + 9) (y^2 − 16) + (x^2 − 9)^2 + (y^2 − 16)^2 = 0')
plt.axhline(0, color='black',linewidth=0.5)
plt.axvline(0, color='black',linewidth=0.5)
from math import sqrt
# punkty osobliwe
plt.plot(0, sqrt(7), 'ro')
plt.plot(0, -sqrt(7), 'ro')


plt.savefig('z9.2.png')

plt.clf()

#3. 350x^2y^2 − 15^2 (x^2 + y^2) + 12^2 (x^4 + y^4) + 81 = 0
x = np.linspace(-3, 3, 400)
y = np.linspace(-3, 3, 400)
X, Y = np.meshgrid(x, y)

Z = 350*(X**2)*(Y**2) - (15**2)*(X**2 + Y**2) + (12**2)*(X**4 + Y**4) + 81


plt.figure(figsize=(8, 8))
plt.contour(X, Y, Z, levels=[0], colors='blue')
plt.xlabel('x')
plt.ylabel('y')
plt.title('350x^2y^2 − 15^2 (x^2 + y^2) + 12^2 (x^4 + y^4) + 81 = 0')
plt.axhline(0, color='black',linewidth=0.5)
plt.axvline(0, color='black',linewidth=0.5)
#brak punktów osobliwych
plt.savefig('z9.3.png')