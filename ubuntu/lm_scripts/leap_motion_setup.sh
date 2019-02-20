#!/bin/bash 

tar -xvf Leap_Motion_Setup_Linux_2.3.1.tgz
cd Leap_Motion_Installer_Packages_release_public_linux
sudo apt-get install libgl1-mesa-dri libgl1-mesa-glx
sudo dpkg --install Leap-*-x64.deb



