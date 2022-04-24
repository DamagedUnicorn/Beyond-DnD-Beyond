#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Apr  5 10:02:28 2017

@author: ThorKnudsen
"""
from scipy import stats
import numpy as np
from matplotlib import pyplot as plt

# ------------------------------------ X ----------------------------------- #
'''
X_right_down = [-3930.92, -3930.67, -3930.45, -3930.94, -3930.45, -3930.67,
                -3931.09, -3931.01, -3930.89, -3931.36, -3931.04, -3931.19,
                -3931.27, -3931.19, -3931.46, -3931.26, -3931.34, -3931.67,
                -3931.78, -3931.35]

X_right_up   = [4289.95, 4289.63, 4289.35, 4289.38, 4289.20, 4288.65, 4288.51,
                4288.63, 4288.42, 4288.06, 4288.18, 4288.03, 4287.86, 4287.65,
                4287.30, 4287.21, 4287.02, 4287.30, 4286.86, 4287.09]

Y_top_down   = [79.21, 78.79, 78.23, 78.41, 78.39, 78.14, 78.05, 78.06, 77.94,
                78.46, 78.24, 78.14, 77.40, 77.00, 77.77, 77.67, 77.88, 77.77,
                77.77, 77.43]

Y_top_up     = [323.63, 323.23, 323.38, 324.07, 324.15, 323.87, 324.40, 324.05,
                324.10, 324.39, 324.06, 324.43, 324.83, 324.54, 324.55, 324.43,
                324.26, 324.21, 324.51, 324.26]

Z_front_down = [235.39, 235.51, 236.33, 236.60, 236.38, 236.44, 236.98, 236.89,
                236.47, 236.46, 236.73, 236.61, 236.81, 237.09, 236.96, 237.00,
                236.91, 236.82, 236.95, 236.83]

Z_front_up   = [91.37, 91.33, 90.40, 90.42, 90.19, 90.46, 89.77, 89.89, 89.69,
                89.28, 88.75, 89.48, 89.61, 89.18, 89.01, 88.87, 88.34, 88.67,
                88.25, 88.22]

combined_x = []

for i in range(20):
    combined_x.append(X_right_down[i])
for i in range(20):
    combined_x.append(X_right_up[i])
for i in range(20):
    combined_x.append(Y_top_down[i])
for i in range(20):
    combined_x.append(Y_top_up[i])
for i in range(20):
    combined_x.append(Z_front_down[i])
for i in range(20):
    combined_x.append(Z_front_up[i])

x_values = np.array(combined_x)

#--------------------

X1 = [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1]
X2 = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
Y1 = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
Y2 = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
Z1 = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
Z2 = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]

combined_y = []

for i in range(20):
    combined_y.append(X1[i])
for i in range(20):
    combined_y.append(X2[i])
for i in range(20):
    combined_y.append(Y1[i])
for i in range(20):
    combined_y.append(Y2[i])
for i in range(20):
    combined_y.append(Z1[i])
for i in range(20):
    combined_y.append(Z2[i])

y_values = np.array(combined_y)
'''
# ------------------------------------ Y ----------------------------------- #
'''
X_right_down = [28.68, 28.69, 28.88, 28.75, 28.95, 29.16, 29.01, 29.09, 29.05,
                28.85, 28.85, 28.88, 29.12, 29.17, 28.70, 28.74, 29.36, 29.28,
                29.20, 29.30]

X_right_up   = [-146.70, -147.07, -146.71, -147.07, -146.95, -146.63, -146.61,
                -146.74, -146.47, -146.58, -146.36, -146.15, -146.07, -146.66,
                -146.10, -146.17, -146.43, -146.19, -146.45, -146.29]

Y_top_down   = [-4136.39, -4135.85, -4136.06, -4135.85, -4136.01, -4136.25,
                -4136.05, -4136.02, -4136.15, -4136.25, -4136.12, -4136.19,
                -4135.82, -4135.89, -4135.78, -4135.67, -4135.96, -4135.68,
                -4135.78, -4135.87]

Y_top_up     = [4061.64, 4061.50, 4061.59, 4061.31, 4061.14, 4061.42, 4061.36,
                4061.27, 4061.25, 4061.18, 4061.25, 4061.28, 4060.99, 4061.24,
                4061.04, 4061.38, 4061.25, 4061.36, 4061.28, 4061.25]

Z_front_down = [-49.81, -49.79, -50.16, -50.28, -50.56, -50.46, -50.76, -50.57,
                -50.52, -50.30, -50.71, -50.54, -50.46, -50.54, -51.01, -50.38,
                -50.28, -50.19, -49.86, -49.97]

Z_front_up   = [-168.10, -167.89, -167.40, -166.89, -166.27, -165.88, -165.57,
                -165.01, -165.05, -164.30, -164.18, -164.03, -163.97, -163.25,
                -163.05, -162.39, -162.43, -162.38, -162.19, -161.90]

combined_x = []

for i in range(20):
    combined_x.append(X_right_down[i])
for i in range(20):
    combined_x.append(X_right_up[i])
for i in range(20):
    combined_x.append(Y_top_down[i])
for i in range(20):
    combined_x.append(Y_top_up[i])
for i in range(20):
    combined_x.append(Z_front_down[i])
for i in range(20):
    combined_x.append(Z_front_up[i])

x_values = np.array(combined_x)

#--------------------

X1 = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
X2 = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
Y1 = [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1]
Y2 = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
Z1 = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
Z2 = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]

combined_y = []

for i in range(20):
    combined_y.append(X1[i])
for i in range(20):
    combined_y.append(X2[i])
for i in range(20):
    combined_y.append(Y1[i])
for i in range(20):
    combined_y.append(Y2[i])
for i in range(20):
    combined_y.append(Z1[i])
for i in range(20):
    combined_y.append(Z2[i])

y_values = np.array(combined_y)
'''
# ------------------------------------ Z ----------------------------------- #

X_right_down = [-643.72, -642.76, -642.91, -642.33, -641.77, -642.14, -641.96,
                -641.67, -640.40, -640.15, -640.06, -639.94, -639.61, -639.78,
                -638.31, -639.61, -638.56, -638.09, -637.92, -637.52]

X_right_up   = [-548.85, -548.40, -547.20, -546.91, -544.95, -543.94, -543.50,
                -542.87, -541.91, -540.22, -539.03, -537.97, -536.92, -536.05,
                -534.82, -534.13, -533.62, -533.19, -533.11, -532.58]

Y_top_down   = [-330.95, -330.40, -329.30, -328.83, -328.17, -327.26, -328.13,
                -328.92, -328.04, -328.79, -328.96, -327.82, -324.51, -323.41,
                -325.31, -326.22, -326.34, -327.96, -327.97, -326.63]

Y_top_up     = [-396.37, -395.79, -396.29, -399.35, -400.72, -401.42, -401.94,
                -402.79, -403.54, -403.53, -403.20, -404.44, -404.77, -404.28,
                -404.16, -405.31, -402.79, -401.80, -402.55, -402.73]

Z_front_down = [-4611.47, -4611.81, -4613.71, -4614.79, -4616.40, -4615.08,
                -4617.51, -4616.77, -4616.26, -4616.38, -4618.09, -4618.32,
                -4618.95, -4621.26, -4620.50, -4620.34, -4619.93, -4619.68,
                -4619.73, -4620.61]

Z_front_up   = [3745.85, 3744.88, 3744.27, 3744.04, 3743.48, 3742.88, 3743.23,
                3742.97, 3743.74, 3743.83, 3744.36, 3742.07, 3740.28, 3740.32,
                3741.17, 3740.68, 3740.03, 3740.72, 3740.44, 3740.38]

combined_x = []

for i in range(20):
    combined_x.append(X_right_down[i])
for i in range(20):
    combined_x.append(X_right_up[i])
for i in range(20):
    combined_x.append(Y_top_down[i])
for i in range(20):
    combined_x.append(Y_top_up[i])
for i in range(20):
    combined_x.append(Z_front_down[i])
for i in range(20):
    combined_x.append(Z_front_up[i])

x_values = np.array(combined_x)

#--------------------

X1 = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
X2 = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
Y1 = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
Y2 = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
Z1 = [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1]
Z2 = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]

combined_y = []

for i in range(20):
    combined_y.append(X1[i])
for i in range(20):
    combined_y.append(X2[i])
for i in range(20):
    combined_y.append(Y1[i])
for i in range(20):
    combined_y.append(Y2[i])
for i in range(20):
    combined_y.append(Z1[i])
for i in range(20):
    combined_y.append(Z2[i])

y_values = np.array(combined_y)

# ---------------------------- Calculate regression------------------------- #

slope, intercept, r_value, p_value, std_err = stats.linregress(x_values,y_values)

def reg(x):
    return (slope * x) + intercept

x_reg = []
y_reg = []

a = int(min(x_values))
b = int(max(x_values))

for i in range(a, b, 1):
    y_reg.append(reg(i))

for i in range(a, b, 1):
    x_reg.append(i)

#----------------------- Plot points and regression ------------------------ #

plt.plot(x_reg, y_reg, '-k', label = 'Linear regression')
plt.plot(x_values, y_values, '.b', label = 'Measured data')
plt.legend()
plt.title('Linear regression for acceleration in the Z axis')
plt.xlabel('Digital value')
plt.ylabel('g(s)')
plt.grid(True)
plt.show()
print('y = %.8Ex + %.8E' % (slope, intercept))