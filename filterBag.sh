#!/bin/bash

if [[ $# -eq 0 ]] ; then
    echo 'enter 1: bagfile input, 2: output bagfile name'
    exit 0
fi

rosbag filter $1 $2 "topic in ['/alt_msgs','/current_state','/imu/data','/vo_updates','/mekf/current_state']"
