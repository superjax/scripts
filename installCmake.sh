#!/bin/bash
cd ~/Downloads
wget http://www.cmake.org/files/v2.8/cmake-2.8.12.1.tar.gz
tar xf cmake-2.8.12.1.tar.gz
cd cmake-2.8.12.1/
./bootstrap 
make
sudo make install 
cd ..
sudo mv cmake-2.8.12.1/ /opt/
cmake -version
