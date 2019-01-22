#!/usr/bin/python
import sys
import matplotlib.pyplot as plt

def calc_bitrate(filename):
    pkt_sizes = []
    avg_bitrate = []
    cur_bitrate = []
    bits = 0
    duration = .0
    pkt_size = 0
    pkt_duration = .0
    with open(filename) as myfile:
        for line in myfile:
            name, var = line.partition("=")[::2]
            flag = False
            if name == "pkt_duration_time":
                pkt_duration = float(var)
                duration = duration + pkt_duration

            if name == "pkt_size":
                pkt_size = (int(var)*8)/1000.0
                pkt_sizes.append(pkt_size)
                bits = bits + pkt_size;
                flag = True

            if flag:
                avg_bitrate.append(bits/duration)
                cur_bitrate.append(pkt_size/pkt_duration)
                flag = False

    return avg_bitrate, cur_bitrate


f=open(sys.argv[1],"r")
files=f.read().splitlines()
for filename in files:
    avg_bitrate, cur_bitrate = calc_bitrate(filename)
    plt.plot(cur_bitrate, label=filename)
    plot_label=str(avg_bitrate[-1])+" " + filename
#    plt.plot(avg_bitrate, label=plot_label)

plt.grid(True)
plt.legend()
plt.show()
