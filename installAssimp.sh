#!/bin/bash
#mkdir assimp
#cd assimp
#wget http://sourceforge.net/projects/assimp/files/assimp-3.0/assimp--3.0.1270-full.zip/download
#mv download assimp3.zip
#unzip assimp3.zip
cd assimp--3.0.1270-sdk
cmake CMakeLists.txt
make
sudo apt-get install checkinstall
sudo checkinstall
cd ..
sudo mv assimp--3.0.1270-sdk /opt/assimp3
cd ..
rm -rf assimp
