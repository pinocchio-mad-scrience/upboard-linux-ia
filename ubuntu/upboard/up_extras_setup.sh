#!/bin/bash

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
cd upboard-extras_0.1-1.debian/debian
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
sudo fallocate -l 3G /swapfile
sudo dd if=/dev/zero of=/swapfile bs=3072 count 1048576

# Set the correct permissions
sudo chmod 600 /swapfile

# Permanent set up a Linux swap area
sudo swapon /swapfile
echo "/swapfile swap swap defaults 0 0" >> /etc/fstab

# Verify the swap status
sudo swapon --show
sudo free -h

# Adjust the swappiness value
sudo sysctl vm.swappiness=10

# Note: To make this parameter persist across reboots append the following line to the /etc/sysctl.conf file
# vm.swappiness=10

sudo reboot
