#!/bin/bash 

# Linux Ubuntu Installation
sudo apt-key adv --keyserver keys.gnupg.net --recv-key C8B3A55A6F3EFCDE || sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key C8B3A55A6F3EFCDE
sudo add-apt-repository "deb http://realsense-hw-public.s3.amazonaws.com/Debian/apt-repo bionic main" -u

# Make Ubuntu Up-to-date
sudo apt-get update && sudo apt-get upgrade && sudo apt-get dist-upgrade

# Install linux 4.15.0-37 headers
sudo apt-get install linux-headers-4.15.0-37
sudo apt-get install linux-headers-4.15.0-37-generic  

# Create symbolic link for DKMS to install the modules
# Workaround - Hardcode kernel version 
# Applied since my linux headers does not match with the modules version
sudo ln -s /usr/src/linux-headers-4.15.0-37  /lib/modules/4.15.0-37-generic/build

sudo apt-get install -y librealsense2-dkms librealsense2-utils librealsense2-dev librealsense2-dbg

# Verify ucvcvideo
modinfo uvcvideo | grep "version:"

echo "Output should be somethins like this:"
echo "version:        1.1.2.realsense-1.3.4"

echo "Complete install packages"

# Update OS Boot and reboot to enforce the correct kernel selection
sudo update-grub 

echo "Complete instalation"
echo "The system will reboot in 10 seconds"
sudo reboot

