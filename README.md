[AAERON UPBOARD] - Yocto - Community Intelligent Assistant (IA)

Personal Robot Assistant with Artificial Intelligence develop using Intel Robotics Dev Kit

Linux distribution recommended:
UBUNTU-14.04, UBUNTU-16.04

GCC compiler recommended version 
gcc-7.2.0-r0

Target Features:
- Basic Yocto interface
- Boot from USB/Install on EMMC
- Power on using a power bank 5V/2.4 A
- USB WIFI/Audio Mic-Out
- ETH0 Internet connection
- USB stick and external HDD 
- Improved audio/video quality using QT5
- Mouse and Kerboard
- Gcc and G++ on target compiler
- Most of Linux distribution library's and packages

Linux distribution build enviroment:
sudo apt-get install gawk wget git-core diffstat unzip \ 

texinfo gcc-multilib build-essential chrpath socat libsdl1.2-dev xterm

To get the project you need to have git clone next projects:

git clone git://git.yoctoproject.org/poky.git

git checkout c2b641c8a0c4fd71fcb477d788a740c2c26cddce

git branch -a

git clone git://git.yoctoproject.org/meta-intel.git

cd meta-intel

git checkout 5adbf6df4fd89e7531ccccfb9cec7a5314d635f0

git clone git://git.openembedded.org/meta-openembedded.git

cd meta-openembedded

git checkout 6e3fc5b8d904d06e3aa77e9ec9968ab37a798188

git clone https://github.com/pinocchio-mad-scrience/upboard-yocto-ia.git

git clone git://github.com/meta-qt5/meta-qt5.git

cd meta-qt5

git checkout 7a52f924a0298857db99be20aca1484bb2b4e163

A. To compile and build a simple image on Linux distribution from the source directory:

export TEMPLATECONF=/home/[username]/[poky_dir]/prj-keya/conf 

source setup-enviroment 

bitbake core-image-minimal

B. To compile and build a full image on Linux distribution from the source directory:

export TEMPLATECONF=/home/[username]/[poky_dir]/prj-keya/conf 

bitbake upboard-image-sato

