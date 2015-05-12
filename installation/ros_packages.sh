#!/bin/sh

#color functions
COFF="\033[0m"
function red    { echo -e "\033[1;31m$@ ${COFF}"; }
function green  { echo -e "\033[1;32m$@ ${COFF}"; }
function yellow { echo -e "\033[1;33m$@ ${COFF}"; }
function blue   { echo -e "\033[1;34m$@ ${COFF}"; }

yellow "Installing Relative Nav Specific ROS Packages"
blue "NAVFN"
sudo apt-get install -y ros-indigo-navfn

blue "Control Toolbox"
sudo apt-get install -y ros-indigo-control-toolbox

blue "GLUT"
sudo apt-get install -y freeglut3-dev

blue "Libbullet"
sudo apt-get install -y libbullet-dev

blue "G2o"
sudo apt-get install -y ros-indigo-libg2o

blue "SuiteSpares"
sudo apt-get install -y libsuitesparse-dev

blue "Rosserial"
sudo apt-get install -y ros-indigo-rosserial-arduino
sudo apt-get install -y ros-indigo-rosserial

blue "pcl-ros"
sudo apt-get install -y ros-indigo-pcl-ros

blue "geodesy"
sudo apt-get install -y ros-indigo-geodesy

blue "joyConfig"
sudo apt-get install -y joy

blue "camera calibration parsers"
sudo apt-get install -y ros-indigo-camera-calibration-parsers 

blue "Openni2"
sudo apt-get install -y ros-indigo-openni2-launch
sudo apt-get install -y ros-indigo-openni2-camera
