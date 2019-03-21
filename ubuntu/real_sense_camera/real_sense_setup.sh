#!/bin/bash 

# Install the latest Intel RealSense SDK 2.0
sudo apt-key adv --keyserver keys.gnupg.net --recv-key C8B3A55A6F3EFCDE || sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key C8B3A55A6F3EFCDE
# Ubuntu 16 LTS:
sudo add-apt-repository "deb http://realsense-hw-public.s3.amazonaws.com/Debian/apt-repo xenial main" -u

sudo apt-get install -y librealsense2-dkms librealsense2-utils librealsense2-dev librealsense2-dbg

modinfo uvcvideo | grep "version:"

echo "Output should be somethins like this:"
echo "version:        1.1.2.realsense-1.3.4"

echo "Complete install packages"

