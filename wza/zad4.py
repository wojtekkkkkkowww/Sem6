import matplotlib.pyplot as plt
import numpy as np

theta = np.linspace(0, 2*np.pi, 1000)
r = np.sin(2*theta)

x = r * np.cos(theta)
y = r * np.sin(theta)
plt.plot(x, y)         
plt.savefig('zad4.png')