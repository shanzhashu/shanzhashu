import matplotlib.pyplot as plt
import numpy as np
from mpl_toolkits.mplot3d import Axes3D

fig = plt.figure()
ax = fig.add_subplot(projection='3d')
ax.set_title('3D Color Cube', pad=1, fontsize='10')
ax.view_init(45, 60)

ax.set_xlabel('x ', color='r', fontsize='14')
ax.set_ylabel('y ', color='g', fontsize='14')
ax.set_zlabel('z ', color='b', fontsize='14')

for x in range(15):
     xs = [x] * 256
     ys = []
     zs = []
     cl = []
     for y in range(16):
        for t in range(16):
            ys.append(y)
        for z in range(16):
            zs.append(z)
            cl.append([x*17/255, y*17/255, z*17/255, 1])

     ax.scatter(xs, ys, zs, c=cl,s=100, marker='s')

plt.show()