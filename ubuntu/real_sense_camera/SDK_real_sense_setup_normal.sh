#!/bin/bash 

# Get the latest Intel RealSense SDK 2.0
sudo mkdir -p $HOME/code
cd code
git clone https://github.com/IntelRealSense/librealsense.git
cd librealsense
sudo apt-get install git libssl-dev libusb-1.0-0-dev pkg-config libgtk-3-dev

# Ubuntu 16 LTS:
sudo apt-get install libglfw3-dev

# Install Intel Realsense permission scripts located in librealsense source directory
sudo cp config/99-realsense-libusb.rules /etc/udev/rules.d/
sudo udevadm control --reload-rules && udevadm trigger

# Build and apply patched kernel modules 
./scripts/patch-realsense-ubuntu-lts.sh

# Building librealsense2 SDK
sudo add-apt-repository ppa:ubuntu-toolchain-r/test
sudo apt-get update
sudo apt-get install gcc-5 g++-5
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-5 60 --slave /usr/bin/g++ g++ /usr/bin/g++-5
sudo update-alternatives --set gcc "/usr/bin/gcc-5"
mkdir build && cd build

# Compile and isntall librealsene2 SDK
sudo cmake -DCMAKE_BUILD_TYPE=Release ../
sudo make -j4 
sudo make install




