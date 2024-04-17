import matplotlib.pyplot as plt
import numpy as np

fig = plt.figure()
ax = fig.add_subplot(111,projection='3d')

# V1 = V(z - x^2 - y^2)
# V1 = {(x,y,z) : z = x^2 + y^2}
x = np.linspace(-5, 5, 100)
y = np.linspace(-5, 5, 100)
x, y = np.meshgrid(x, y)
z = x**2 + y**2

ax.plot_surface(x, y, z,color = 'b')
plt.savefig('v1.png')
ax.clear()


#V2 = V(z^2 - x^2 - y^2)
#V2 = {(x,y,z) : z^2 = x^2 + y^2} = {(x,y,z) : z = sqrt(x^2 + y^2)} U {(x,y,z) : z = -sqrt(x^2 + y^2)}
x = np.linspace(-5, 5, 100)
y = np.linspace(-5, 5, 100)
x, y = np.meshgrid(x, y)

z = np.sqrt(x**2 + y**2)
ax.plot_surface(x, y, z,color = 'b')
z = -np.sqrt(x**2 + y**2)
ax.plot_surface(x, y, z,color = 'r')

plt.savefig('v2.png')
ax.clear()


#V3 = V(z-x^2+y^2)
#V3 = {(x,y,z) : z = x^2 - y^2}
x = np.linspace(-5,5,100)
y = np.linspace(-5,5,100)
x,y = np.meshgrid(x,y)
z = x**2 - y**2 

ax.plot_surface(x, y, z,color = 'b')
plt.savefig('v3.png')
ax.clear()


# V4 = V(xz,yz)
# V4 = {(x,y,z) : x*z = 0 and y*z = 0}
# V4 = A U Z , A = {(x,y,z) : z = 0} , Z = {(x,y,z) : y = 0 and x = 0}

# Plotting A1
x = np.linspace(-5,5,100)
y = np.linspace(-5,5,100)
x,y = np.meshgrid(x,y)
z = np.zeros((100,100))
ax.plot_surface(x, y, z, color='b', alpha=0.5)

# Z to oś Z 
z = np.linspace(-5, 5, 100)
x = np.zeros(100)
y = np.zeros(100)
ax.plot(x, y, z, color='r')

plt.savefig('v4.png')
ax.clear()