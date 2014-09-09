#!/bin/bash

# Check to make sure Ubuntu and ROS distros are correct
echo "This script is intended for OpenCV 2.4.8, Ubuntu 14.04, and ROS Indigo."
read -p "Are you sure you want to proceed?" -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
  # Copy files
  echo " "
  echo "Copying required files to temporary directory"
  mkdir ~/tmp_opencv
  cd ~/tmp_opencv
  
  scp -r magiccvs:/relative_nav/opencv_nonfree . || { echo 'SCP failed, is your ssh config file setup properly?' ; rm -r ~/tmp_opencv; exit 1; }
  
  # Move files to appropriate locations
  echo "Moving include files to /usr/include/opencv2/"
  sudo cp -r ~/tmp_opencv/opencv_nonfree/include/* /usr/include/opencv2/ || { echo 'Cleaning up tmp files...'; rm -r ~/tmp_opencv; exit 1; }
  echo "Done."
  echo "Moving lib files to /usr/lib/x86_64-linux-gnu/"
  sudo cp ~/tmp_opencv/opencv_nonfree/lib/* /usr/lib/x86_64-linux-gnu/ || { echo 'Cleaning up tmp files...'; rm -r ~/tmp_opencv; exit 1; }
  echo "Done."
  echo "Moving share files to /usr/share/OpenCV/"
  sudo cp ~/tmp_opencv/opencv_nonfree/share/OpenCV/* /usr/share/OpenCV/ || { echo 'Cleaning up tmp files...'; rm -r ~/tmp_opencv; exit 1; }
  echo "Done."
  
  # Cleanup
  echo "Cleaning up tmp files..."
  rm -rf ~/tmp_opencv || { echo 'Cleanup failed, manually delete ~/tmp_opencv' ; exit 1;}
  echo "Done."
fi
