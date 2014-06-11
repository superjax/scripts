#!/bin/bash
function die 
  { echo >&2 "$@"; exit 1; }

[ "$#" -eq 1 ] || die "1 argument required, $# provided"

mkdir -p ~/gps_denied
sudo mount -t cifs //fs-caedm.et.byu.edu/$1/groups/gps-denied ~/gps_denied -o user=$1,rw,uid=$USER,gid=$USER

