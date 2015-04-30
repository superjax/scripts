#!/bin/sh

#color functions
COFF="\033[0m"
function red    { echo -e "\033[1;31m$@ ${COFF}"; }
function green  { echo -e "\033[1;32m$@ ${COFF}"; }
function yellow { echo -e "\033[1;33m$@ ${COFF}"; }
function blue   { echo -e "\033[1;34m$@ ${COFF}"; }

#Install ROS
green "Install ROS Indigo for Ubuntu 14.10 LTS Trusty based off of wiki.ros.org installation guide"
blue "Setup your sources.list"

sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu trusty main" > /etc/apt/sources.list.d/ros-latest.list'

blue "Setup up your keys"

wget https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -O - | sudo apt-key add - 

blue "Installation"

sudo apt-get update
sudo apt-get -y install ros-indigo-desktop-full

blue "Initialize rosdep"

sudo rosdep init
rosdep update

blue "Ros Environment setup"
echo "source /opt/ros/indigo/setup.bash" >> ~/.bashrc
source ~/.bashrc

blue "Getting rosinstall"
sudo apt-get -y install python-rosinstall

blue "Getting wstool"
sudo apt-get -y install python-wstool
