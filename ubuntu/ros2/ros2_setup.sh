#!/bin/bash

# Set Locale
sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
echo "export LANG=en_US.UTF-8" >> ~/.bashrc

# Add the ROS 2 apt repository
sudo apt update && sudo apt install curl gnupg2 lsb-release
curl http://repo.ros2.org/repos.key | sudo apt-key add -

sudo sh -c 'echo "deb [arch=amd64,arm64] http://packages.ros.org/ros2/ubuntu `lsb_release -cs` main" > /etc/apt/sources.list.d/ros2-latest.list'
# Install ROS 2 packages
export CHOOSE_ROS_DISTRO=ardent
sudo apt update
sudo apt install ros-$CHOOSE_ROS_DISTRO-desktop
sudo apt install ros-$CHOOSE_ROS_DISTRO-ros-base
sudo apt install python3-pip
sudo pip3 install argcomplete

# Sourcing the setup script
source /opt/ros/$CHOOSE_ROS_DISTRO/setup.bash
echo "source /opt/ros/$CHOOSE_ROS_DISTRO/setup.bash" >> ~/.bashrc

# Install additional RMW implementations

sudo apt update && sudo apt install -y \
  build-essential \
  cmake \
  git \
  python3-colcon-common-extensions \
  python3-pip \
  python-rosdep \
  python3-vcstool \
  wget
# install some pip packages needed for testing
python3 -m pip install -U \
  argcomplete \
  flake8 \
  flake8-blind-except \
  flake8-builtins \
  flake8-class-newline \
  flake8-comprehensions \
  flake8-deprecated \
  flake8-docstrings \
  flake8-import-order \
  flake8-quotes \
  git+https://github.com/lark-parser/lark.git@0.7d \
  pytest-repeat \
  pytest-rerunfailures \
  pytest \
  pytest-cov \
  pytest-runner \
  setuptools

# install Fast-RTPS dependencies
sudo apt install --no-install-recommends -y \
  libasio-dev \
  libtinyxml2-dev

# Get ROS 2.0 code
mkdir -p ~/ros2_ws/src
cd ~/ros2_ws
wget https://raw.githubusercontent.com/ros2/ros2/master/ros2.repos
vcs import src < ros2.repos

# Install dependencies using rosdep
sudo rosdep init
rosdep update
# [Ubuntu 16.04]
rosdep install --from-paths src --ignore-src --rosdistro crystal -y --skip-keys "console_bridge fastcdr fastrtps libopensplice67 libopensplice69 python3-lark-parser rti-connext-dds-5.3.1 urdfdom_headers"

# Build the code in the workspace
cd ~/ros2_ws/
# On Ubuntu Linux Xenial Xerus 16.04
colcon build --symlink-install --packages-ignore qt_gui_cpp rqt_gui_cpp

sudo apt install clang
echo "export CC=clang" >> ~/.bashrc
echo "export CXX=clang++" >> ~/.bashrc
colcon build --cmake-force-configure


echo "Complete instalation"


