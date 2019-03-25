#!/bin/bash 

# OpenVINO-Install-Linux 
tar -zxf l_openvino_toolkit_p_*.tgz
cd l_openvino_toolkit_p_*/
sudo -E ./install_cv_sdk_dependencies.sh
sudo ./install.sh

# Configure model TensorFlow and Caffe
sudo apt install python-pip
sudo pip install --upgrade pip
cd /opt/intel/computer_vision_sdk/deployment_tools/model_optimizer/install_prerequisites
sudo ./install_prerequisites.sh
sudo ./install_prerequisites_tf.sh
sudo ./install_prerequisites_caffe.sh

# Install OpenCL Driver for GPU 
cd /opt/intel/computer_vision_sdk/install_dependencies
sudo ./install_NEO_OCL_driver.sh
sudo usermod -a -G video ${USER}
# Install OpenCV 3.4 or later
sudo add-apt-repository "deb http://security.ubuntu.com/ubuntu xenial-security main"
sudo apt update
sudo apt install libjasper1 libjasper-dev
sudo apt-get install -y build-essential cmake git libgtk2.0-dev pkg-config libavcodec-dev \
libavformat-dev libswscale-dev python-dev python-numpy libtbb2 libtbb-dev libjpeg-dev \
libpng-dev libtiff-dev libdc1394-22-dev

mkdir -p ~/code && cd ~/code
git clone https://github.com/opencv/opencv.git
git clone https://github.com/opencv/opencv_contrib.git
cd opencv && git checkout 3.4.2 && cd ..
cd opencv_contrib && git checkout 3.4.2 && cd ..
cd opencv
mkdir build && cd build
sudo cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local -D OPENCV_EXTRA_MODULES_PATH=$HOME/code/opencv_contrib/modules/ ..
make -j8
sudo make install

# librealsense dependency
sudo apt-get install -y libssl-dev libusb-1.0-0-dev pkg-config libgtk-3-dev
sudo apt-get install -y libglfw3-dev libgl1-mesa-dev libglu1-mesa-dev
# numpy and networkx
pip3 install numpy
pip3 install networkx
# libboost
sudo apt-get install -y --no-install-recommends libboost-all-dev
cd /usr/lib/x86_64-linux-gnu
sudo ln -sf libboost_python-py35.so libboost_python3.so

# Building and Installation
echo "ROOT is required instead of sudo"
echo "Type sudo su and enter next commands"
echo "# source /opt/intel/computer_vision_sdk/bin/setupvars.sh"
echo "# cd /opt/intel/computer_vision_sdk/deployment_tools/inference_engine/samples/"
echo "# mkdir build"
echo "# cd build"
echo "# cmake .."
echo "# make -j4"

# set ENV CPU_EXTENSION_LIB and GFLAGS_LIB
echo "export CPU_EXTENSION_LIB=/opt/intel/computer_vision_sdk/deployment_tools/inference_engine/samples/build/intel64/Release/lib/libcpu_extension.so" >> ~/.bashrc
echo "export GFLAGS_LIB=/opt/intel/computer_vision_sdk/deployment_tools/inference_engine/samples/build/intel64/Release/lib/libgflags_nothreads.a" >> ~/.bashrc

# Install ROS2_OpenVINO packages
mkdir -p ~/ros2_overlay_ws/src
cd ~/ros2_overlay_ws/src
git clone https://github.com/intel/ros2_openvino_toolkit
git clone https://github.com/intel/ros2_object_msgs
git clone https://github.com/ros-perception/vision_opencv -b ros2
git clone https://github.com/ros2/message_filters.git
git clone https://github.com/ros-perception/image_common.git -b ros2
git clone https://github.com/intel/ros2_intel_realsense.git

# Build package
source ~/ros2_ws/install/local_setup.bash
source /opt/intel/computer_vision_sdk/bin/setupvars.sh
echo "export OpenCV_DIR=$HOME/code/opencv/build" >> ~/.bashrc
cd ~/ros2_overlay_ws
colcon build --symlink-install
source ./install/local_setup.bash
sudo mkdir -p /opt/openvino_toolkit
sudo ln -sf ~/ros2_overlay_ws/src/ros2_openvino_toolkit /opt/openvino_toolkit/ros2_openvino_toolkit












source /opt/intel/openvino/bin/setupvars.sh
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
catkin_make -j2 -DCATKIN_ENABLE_TESTING=False -DCMAKE_BUILD_TYPE=Release -DOpenCV_DIR=/usr/local/share/OpenCV
catkin_make install
echo "source ~/catkin_ws/devel/setup.bash" >> ~/.bashrc
source ~/.bashrc

# Install OpenVINO™ Toolkit Open Source
sudo apt-get install build-essential
sudo apt-get install cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev
sudo apt-get install python-dev python-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libjasper-dev libdc1394-22-dev
cd ~/code
git clone https://github.com/opencv/opencv.git
git clone https://github.com/opencv/opencv_contrib.git
cd opencv && git checkout 3.3.1 && cd ..
cd opencv_contrib && git checkout 3.3.1 && cd ..
cd opencv
mkdir build && cd build
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local -D OPENCV_EXTRA_MODULES_PATH=$HOME/code/opencv_contrib/modules/ ..
sudo make -j4
sudo make install

# Install OpenCL Driver for GPU
cd ~/Downloads
wget http://registrationcenter-download.intel.com/akdlm/irc_nas/11396/SRB5.0_linux64.zip
unzip SRB5.0_linux64.zip -d SRB5.0_linux64
cd SRB5.0_linux64
sudo apt-get install xz-utils
mkdir intel-opencl
tar -C intel-opencl -Jxf intel-opencl-r5.0-63503.x86_64.tar.xz
tar -C intel-opencl -Jxf intel-opencl-devel-r5.0-63503.x86_64.tar.xz
tar -C intel-opencl -Jxf intel-opencl-cpu-r5.0-63503.x86_64.tar.xz
sudo cp -R intel-opencl/* /
sudo ldconfig

# Install Deep Learning Deployment Toolkit
sudo apt-get install gdal-bin libgdal-dev
mkdir ~/code && cd ~/code
git clone https://github.com/opencv/dldt.git
cd dldt/inference-engine/
git checkout 2018_R4
git submodule init
git submodule update --recursive
sudo ./install_dependencies.sh
mkdir build && cd build
sudo cmake -DCMAKE_BUILD_TYPE=Release -DTHREADING=TBB ..
make -j4
sudo mkdir -p /opt/openvino_toolkit
sudo ln -s ~/code/dldt /opt/openvino_toolkit/dldt

# Install Open Model Zoo(guide)
cd ~/code
git clone https://github.com/opencv/open_model_zoo.git
cd open_model_zoo/demos/
git checkout e238a1ac6bfacf133be223dd9debade7bfcf7dc5
mkdir build && cd build
sudo cmake -DCMAKE_BUILD_TYPE=Release -DTHREADING=TBB /opt/openvino_toolkit/dldt/inference-engine 
make -j8
sudo mkdir -p /opt/openvino_toolkit
sudo ln -s ~/code/open_model_zoo /opt/openvino_toolkit/open_model_zoo

# Other Dependencies

# numpy
pip3 install numpy
# libboost
sudo apt-get install -y --no-install-recommends libboost-all-dev
cd /usr/lib/x86_64-linux-gnu
sudo ln -s libboost_python-py35.so libboost_python3.so

# Building and Installation OpenVino Toolkit
echo "export InferenceEngine_DIR=/opt/openvino_toolkit/dldt/inference-engine/build/" >> ~/.bashrc
echo "export CPU_EXTENSION_LIB=/opt/openvino_toolkit/dldt/inference-engine/bin/intel64/Release/lib/libcpu_extension.so" >> ~/.bashrc
echo "export GFLAGS_LIB=/opt/openvino_toolkit/dldt/inference-engine/bin/intel64/Release/lib/libgflags_nothreads.a" >> ~/.bashrc










