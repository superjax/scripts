#!/bin/python
from pylab import *
import argparse

parser = argparse.ArgumentParser(description='Description of your program')
parser.add_argument('N', type=int, help='number of waypoints')
parser.add_argument('A', type=float, help='amplitude of sin wave')
args = parser.parse_args()


#double step = (double)0.5/(num_waypoints-1);
#  for (int i = 0; i < num_waypoints; i++)
#  {
#      double index = (double)i*1.0;
#      double speed_ramp_function = std::min(ramp_amplitude_*std::sin(M_PI*(0.5+index*step)),1.0);
#      waypoints[i].u = waypoint_speed_*speed_ramp_function*direction(0);
#      waypoints[i].v = waypoint_speed_*speed_ramp_function*direction(1);
#      waypoints[i].w = waypoint_speed_*speed_ramp_function*direction(2);
#  }
  


N = args.N
n = linspace(0,0.5,N)
step = 0.5/(N-1)
for i in range(N):
	print i*step
s = args.A*cos(pi*n)
s = [min(i,1.0) for i in s]
plot(n, s,'.',markersize=20)
plot(n, s)
xlabel('time (s)')
ylabel('voltage (mV)')
grid(True)
show()

