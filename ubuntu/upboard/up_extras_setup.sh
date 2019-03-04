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

sudo reboot
