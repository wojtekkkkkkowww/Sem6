import matplotlib.pyplot as plt
import numpy as np

fig = plt.figure()
ax = fig.add_subplot(111,projection='3d')

# x^2 - zy^2 = 0, -> x = sqrt(zy^2) lub x = -sqrt(zy^2)

z = np.linspace(0,10,100)
y = np.linspace(-10,10,100)
z,y = np.meshgrid(z,y)

x = np.sqrt(y**2 * z)

ax.plot_surface(x, y, z, color='b', alpha=0.5)
ax.plot_surface(-x, y, z, color='b', alpha=0.5)


ax.set_title('x^2 - zy^2 = 0')
plt.savefig('z10.png')
