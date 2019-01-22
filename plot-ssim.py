#!/usr/bin/python
import sys
import matplotlib.pyplot as plt
import matplotlib.patches as mpatches
def get_ssim_result(filename):
    f=open(filename,"r")
    lines=f.readlines()
    result=[]
    for line in lines:
        result.append(float(line.split(' ')[4].split(':')[1]))
    return result

f=open(sys.argv[1],"r")
files=f.read().splitlines()
for filename in files:
    plt.plot(get_ssim_result(filename), label=filename)

plt.grid(True)
plt.legend()
plt.show()
