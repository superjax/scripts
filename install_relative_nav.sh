#o/bin/bash

if [ $1 ]; then
	WORKSPACE=$1
else
	WORKSPACE="rel_nav_workspace"
fi

WORKSPACE_PATH=`pwd`/$WORKSPACE
ORIG_PATH=`pwd`
 
COFF="\033[0m"
function red    { echo -e "\033[1;31m$@ ${COFF}"; }
function green  { echo -e "\033[1;32m$@ ${COFF}"; }
function yellow { echo -e "\033[1;33m$@ ${COFF}"; }
function blue   { echo -e "\033[1;34m$@ ${COFF}"; }
 
if [ ! -d /opt/ros/indigo]; then
  red "Make sure you install ROS indigo first"
  exit 1
fi
source /opt/ros/indigo/setup.bash
 
### prepares catkin workspace with wstool, creates if doesn't exist
if [ ! -d "$WORKSPACE" ]; then
  yellow "$WORKSPACE does not exist!"
  yellow "initializing catkin workspace..."
  mkdir -p ${WORKSPACE_PATH}/src
  cd ${WORKSPACE_PATH}/src
  catkin_init_workspace
  catkin_make -C ../
 
  yellow "adding source setup.bash to .bashrc"
  #echo "source $WORKSPACE_PATH/devel/setup.bash" >> ~/.bashrc
 
  source ~/.bashrc
  yellow "preparing src directory for wstool"
  wstool init
  yellow "$WORKSPACE prepared to set nav packages"
else
 
  ###   directory exists but is not catkinize
  if  cd ${WORKSPACE_PATH}/src; then
    yellow "Change directory to ${WORKSPACE_PATH}/src"
    cd ${WORKSPACE_PATH}/src
    if ! catkin_init_workspace 2>&1 | grep -q already; then
      catkin_make -C ../
      yellow "adding source setup.bash to .bashrc"
      #echo "source $WORKSPACE_PATH/devel/setup.bash" >> ~/.bashrc
      source ~/.bashrc     
    fi
  else
    yellow "Adding /src directory and catkinizing..."
    yellow "Change directory to $WORKSPACE/src"
    mkdir -p ${WORKSPACE_PATH}/src
    cd ${WORKSPACE_PATH}/src
    catkin_init_workspace
    catkin_make -C ../
    yellow "adding source setup.bash to .bashrc"
    #echo "source $WORKSPACE_PATH/devel/setup.bash" >> ~/.bashrc
    source ~/.bashrc
  fi
  pwd;
 
  ###   directory exists but has not been wstool prepared
  if ! [ -e .rosinstall ]; then
    yellow "preparing src dirctory for wstool"
    wstool init
    yellow "$WORKSPACE prepared to set nav packages"
  fi
fi
 
### function to set a package
addRelNavPackages() 
{
  if [ ! -d "$1" ]; then
    yellow "Setting `blue $1`...";
    wstool set ${1} --git -y magiccvs:/git/relative_nav/${1}.git;
    wstool update ${1}; 
  else
    yellow "`blue $1` already exists... skipping to next package";
  fi
}
 
### add directories that you want added from the git here (with a space between). 
for DIRECTORY in "relative_nav_msgs" "mikro_serial" "mikro_relay" \
	"rotor_controller" "control_toolbox" "realtime_tools" "evart_bridge" \
	"rotor_estimator" "relative_nav_launch" "path_planner_geometric" \
	"rel_mekf" "altimeter" "cereal_port" "microstrain_3dmgx2_imu" \
	"visualizer" "vo_rgbd"
do
  addRelNavPackages $DIRECTORY
done
 
source ~/.bashrc
