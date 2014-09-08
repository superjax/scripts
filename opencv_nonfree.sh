#!/bin/bash

# Copy files
echo "Copying required files to temporary directory"
mkdir ~/tmp_opencv
cd ~/tmp_opencv

scp -r magiccvs:/relative_nav/opencv_nonfree . || { echo 'SCP failed, is your ssh config file setup properly?' ; rm -r ~/tmp_opencv; exit 1; }

# Move files to appropriate locations
sudo cp -r ~/tmp_opencv/opencv_nonfree/include/* /usr/include/opencv2/ || { echo 'Cleaning up tmp files...'; rm -r ~/tmp_opencv; exit 1; }
sudo cp ~/tmp_opencv/opencv_nonfree/lib/* /usr/lib/x86_64-linux-gnu/ || { echo 'Cleaning up tmp files...'; rm -r ~/tmp_opencv; exit 1; }
echo "Success"

# Cleanup
echo "Cleaning up tmp files..."
rm -rf ~/tmp_opencv || { echo 'Cleanup failed, manually delete ~/tmp_opencv' ; exit 1;}
echo "Done."
