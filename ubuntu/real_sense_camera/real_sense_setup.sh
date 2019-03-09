#!/bin/bash 

# Install the latest Intel RealSense SDK 2.0
sudo apt-key adv --keyserver keys.gnupg.net --recv-key C8B3A55A6F3EFCDE || sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key C8B3A55A6F3EFCDE
sudo add-apt-repository "deb http://realsense-hw-public.s3.amazonaws.com/Debian/apt-repo bionic main" -u

# Install linux 4.15.0-37 headers
sudo apt-get install linux-headers-4.15.0-37
sudo apt-get install linux-headers-4.15.0-37-generic  

# Create symbolic link for DKMS to install the modules
# Workaround - Hardcode kernel version 
# Applied since my linux headers does not match with the modules version
sudo ln -s /usr/src/linux-headers-4.15.0-37  /lib/modules/4.15.0-37-generic/build

sudo apt-get install -y librealsense2-dkms librealsense2-utils librealsense2-dev librealsense2-dbg

# Install the ROS Melodic distribution
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116
sudo apt update
sudo apt install -y ros-melodic-desktop-full
sudo apt install ros-melodic-opencv*
sudo rosdep init
rosdep update
source /opt/ros/melodic/setup.bash

sudo apt install python-rosinstall python-rosinstall-generator python-wstool build-essential

# Init workspace
mkdir -p ~/catkin_ws/src
cd ~/catkin_ws/src/
git clone https://github.com/ros-visualization/rviz.git
git clone https://github.com/intel/ros_object_analytics
git clone https://github.com/intel/object_msgs.git
git clone https://github.com/ros/ros_comm.git
git clone https://github.com/ros/std_msgs.git
git clone https://github.com/ros/common_msgs.git
git clone https://github.com/ros-perception/perception_pcl
git clone https://github.com/ros-perception/vision_opencv.git

catkin_init_workspace
sed -i '62ifind_package(OpenCV)' CMakeLists.txt
cd ..

# Install Intel RealSense ROS & RVIZ from Sources
rosdep install object_analytics
rosdep install object_msgs
rosdep install rviz
rosdep install ros_comm
rosdep install perception_pcl

catkin_make clean
catkin_make -j2 -DCATKIN_ENABLE_TESTING=False -DCMAKE_BUILD_TYPE=Release
catkin_make install
echo "source ~/catkin_ws/devel/setup.bash" >> ~/.bashrc
source ~/.bashrc


modinfo uvcvideo | grep "version:"

echo "Output should be somethins like this:"
echo "version:        1.1.2.realsense-1.3.4"

echo "Complete install packages"

