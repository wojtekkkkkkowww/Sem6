import numpy as np
import matplotlib.pyplot as plt


plt.gca().set_aspect('equal', adjustable='box')
t = np.linspace(-1000,1000, 100000)
x = (1 - t**2) / (1 + t**2)
y = 2*t / (1 + t**2)
plt.plot(x, y)
plt.plot(-1, 0, 'ro')

plt.savefig('z11.png')