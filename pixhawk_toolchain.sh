#!/bin/bash

sudo apt-get -qq install python-serial python-argparse openocd \
    flex bison libncurses5-dev autoconf texinfo build-essential \
    libftdi-dev libtool zlib1g-dev genromfs wget

sudo apt-get -qq install libc6:i386 libgcc1:i386 gcc-4.6-base:i386 libstdc++5:i386 libstdc++6:i386

cat > $HOME/rule.tmp <<_EOF
# All 3D Robotics (includes PX4) devices
SUBSYSTEM=="usb", ATTR{idVendor}=="26AC", GROUP="plugdev"
# FTDI (and Black Magic Probe) Devices
SUBSYSTEM=="usb", ATTR{idVendor}=="0483", GROUP="plugdev"
# Olimex Devices
SUBSYSTEM=="usb",  ATTR{idVendor}=="15ba", GROUP="plugdev"
_EOF
sudo mv $HOME/rule.tmp /etc/udev/rules.d/10-px4.rules
sudo restart udev

sudo usermod -a -G plugdev $USER
sudo usermod -a -G dialout $USER

pushd .
cd /opt/
sudo wget https://launchpadlibrarian.net/174121628/gcc-arm-none-eabi-4_7-2014q2-20140408-linux.tar.bz2
sudo tar -jxf gcc-arm-none-eabi-4_7-2014q2-20140408-linux.tar.bz2
exportline="export PATH=/opt/gcc-arm-none-eabi-4_7-2014q2/bin:\$PATH"
if grep -Fxq "$exportline" ~/.profile; then echo nothing to do ; else echo $exportline >> ~/.profile; fi
if grep -Fxq "$exportline" ~/.bashrc; then echo nothing to do ; else echo $exportline >> ~/.bashrc; fi
source ~/.bashrc
sudo rm gcc-arm-none-eabi-4_7-2014q2-20140408-linux.tar.bz2
popd

echo "Installation complete. You must log out and back in for changes to take effect."

