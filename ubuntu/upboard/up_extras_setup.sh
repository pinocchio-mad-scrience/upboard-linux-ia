#!/bin/bash -x

# download extra config
wget https://launchpad.net/~ubilinux/+archive/ubuntu/up/+sourcefiles/upboard-extras/0.1-1/upboard-extras_0.1.orig.tar.gz
wget https://launchpad.net/~ubilinux/+archive/ubuntu/up/+sourcefiles/upboard-extras/0.1-1/upboard-extras_0.1-1.debian.tar.xz

# upboard extra config
tar -xvf upboard-extras_0.1.orig.tar.gz
tar -xvf upboard-extras_0.1-1.debian.tar.xz

cd upboard-extras_1.0
sudo cp lib/udev/rules.d/* /lib/udev/rules.d
sudo cp etc/modules-load.d/* /etc/modules-load.d/
cd ..
cd debian
sudo chmod 777 postinst
sudo ./postinst

# gpio functionality
sudo usermod -a -G gpio ${USER}

# leds
sudo usermod -a -G leds ${USER}

# spi
sudo usermod -a -G spi ${USER}

# i2c
sudo usermod -a -G i2c ${USER}

# uart
sudo usermod -a -G dialout ${USER}

# Create Swap file
sudo fallocate -l 6.5G swapfile
sudo dd if=/dev/zero of=swapfile bs=6656 count=1048576

# Set the correct permissions
sudo chmod 600 swapfile

# Permanent set up a Linux swap area to persist across reboots
sudo mkswap swapfile
sudo swapon swapfile
echo "/media/keya87/83280304-3895-4e4c-b64d-43aea22bc2d0/swapfile swap swap defaults 0 0" >> /etc/fstab

# Verify the swap status
sudo swapon --show
sudo free -h

# Adjust the swappiness value
sudo sysctl vm.swappiness=10

# To make this parameter persist across reboots append the following line
echo "vm.swappiness=10" >> /etc/sysctl.conf 

# Install Ubuntu kernel 4.15.0 for UP from PPA on Ubuntu 18.04
sudo add-apt-repository ppa:ubilinux/up
sudo apt update
sudo apt-get autoremove --purge 'linux-.*generic'
sudo apt-get install linux-image-generic-hwe-18.04-upboard
sudo apt dist-upgrade -y

echo "Install Completed/n"
echo "Now reboot the system in 10 seconds"
sleep 10
sudo reboot 
