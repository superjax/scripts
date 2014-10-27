#!/bin/sh

die () {
  echo >&2 "$@"
  exit 1
}

[ "$#" -eq 1 ] || die "1 argument required, $# provided"
echo $1 | grep -E -q '^[0-9.]+$' || die "Numeric argument required, $1 provided"

alt=$1

rostopic pub /desired_altitude -1 relative_nav_msgs/DesiredState "node_id: 1
pose:
  x: 0.0
  y: 0.0
  z: -${alt#-}
  yaw: 0.0
velocity:
  x: 0.0
  y: 0.0
  z: 0.0
  yaw: 0.0
acceleration:
  x: 0.0
  y: 0.0
  z: 0.0
  yaw: 0.0" 

rostopic pub -1 /rviz_goal geometry_msgs/PoseStamped "header:
  seq: 0
  stamp:
    secs: 0
    nsecs: 0
  frame_id: ''
pose:
  position:
    x: 0.0
    y: 0.0
    z: 0.0
  orientation:
    x: 0.0
    y: 0.0
    z: 0.0
    w: 0.0" 
