#!/bin/bash 

# OpenVINO-Install-Linux 
#tar -zxf l_openvino_toolkit_p_*.tgz
#cd l_openvino_toolkit_p_*/
sudo -E ./install_openvino_dependencies.sh
#sudo ./install.sh

# Configure model TensorFlow and Caffe
sudo apt install python-pip
sudo pip install --upgrade pip
cd /opt/intel/openvino_*/deployment_tools/model_optimizer/install_prerequisites
sudo ./install_prerequisites.sh

# Configure the Neural Compute Stick USB Driver
cd ~/Downloads
cat <<EOF > 97-usbboot.rules
SUBSYSTEM=="usb", ATTRS{idProduct}=="2150", ATTRS{idVendor}=="03e7", GROUP="users", MODE="0666", ENV{ID_MM_DEVICE_IGNORE}="1"
SUBSYSTEM=="usb", ATTRS{idProduct}=="2485", ATTRS{idVendor}=="03e7", GROUP="users", MODE="0666", ENV{ID_MM_DEVICE_IGNORE}="1"
SUBSYSTEM=="usb", ATTRS{idProduct}=="f63b", ATTRS{idVendor}=="03e7", GROUP="users", MODE="0666", ENV{ID_MM_DEVICE_IGNORE}="1"
EOF

sudo cp 97-usbboot.rules /etc/udev/rules.d/
sudo udevadm control --reload-rules
sudo udevadm trigger
sudo ldconfig
rm 97-usbboot.rules

# Test the Installation
cd /opt/intel/openvino_*/deployment_tools/demo
sudo ./demo_security_barrier_camera.sh -d MYRIAD
sudo ./demo_squeezenet_download_convert_run.sh -d MYRIAD

# Install OpenCL Driver for GPU 
sudo mkdir neo
sudo chmod 777 neo
cd neo
wget https://github.com/intel/compute-runtime/releases/download/19.18.12932/intel-gmmlib_19.1.1_amd64.deb
wget https://github.com/intel/compute-runtime/releases/download/19.18.12932/intel-igc-core_1.0.3-1844_amd64.deb
wget https://github.com/intel/compute-runtime/releases/download/19.18.12932/intel-igc-opencl_1.0.3-1844_amd64.deb
wget https://github.com/intel/compute-runtime/releases/download/19.18.12932/intel-opencl_19.18.12932_amd64.deb
wget https://github.com/intel/compute-runtime/releases/download/19.18.12932/intel-ocloc_19.18.12932_amd64.deb
sudo dpkg -i *.deb

sudo usermod -a -G video ${USER}
# Install OpenCV 3.4 or later
sudo add-apt-repository "deb http://security.ubuntu.com/ubuntu xenial-security main"
sudo apt update
sudo apt install libjasper1 libjasper-dev
# numpy and networkx
pip3 install numpy
pip3 install networkx
sudo apt-get install -y build-essential cmake git libgtk2.0-dev pkg-config libavcodec-dev \
libavformat-dev libswscale-dev python-dev python-numpy libtbb2 libtbb-dev libjpeg-dev \
libpng-dev libtiff-dev libdc1394-22-dev

mkdir -p ~/code && chmod 777 ~/code && cd ~/code
git clone https://github.com/opencv/opencv.git
git clone https://github.com/opencv/opencv_contrib.git
cd opencv && git checkout 3.4.2 && cd ..
cd opencv_contrib && git checkout 3.4.2 && cd ..
cd opencv
mkdir build && cd build
sudo cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local -D OPENCV_EXTRA_MODULES_PATH=$HOME/code/opencv_contrib/modules/ ..
sudo make -j4
sudo make install

# librealsense dependency
sudo apt-get install -y libssl-dev libusb-1.0-0-dev pkg-config libgtk-3-dev libcanberra-gtk-module
sudo apt-get install -y libglfw3-dev libgl1-mesa-dev libglu1-mesa-dev

# libboost
sudo apt-get install -y --no-install-recommends libboost-all-dev
cd /usr/lib/x86_64-linux-gnu
sudo ln -sf libboost_python-py36.so libboost_python3.so

# Building and Installation the samples
echo "ROOT is required instead of sudo"
echo "Type sudo su and enter next commands"
echo "# source /opt/intel/openvino_*/bin/setupvars.sh"
echo "# cd /opt/intel/openvino_*/deployment_tools/inference_engine/samples/"
echo "# mkdir build"
echo "# cd build"
echo "# cmake .."
echo "# make -j4"

# Install OpenCL Driver for GPU
cd ~/code
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

sudo mkdir /opt/openvino_toolkit/

# Install Deep Learning Deployment Toolkit
mkdir ~/code && cd ~/code
git clone https://github.com/opencv/dldt.git
cd dldt/inference-engine/
git checkout 2019_R1.1
git submodule init
git submodule update --recursive
./install_dependencies.sh
mkdir build && cd build
cmake -DCMAKE_BUILD_TYPE=Release -DENABLE_GNA=OFF -DENABLE_MKL_DNN=OFF ..
sudo make -j8
sudo mkdir -p /opt/openvino_toolkit
sudo ln -sf ~/code/dldt /opt/openvino_toolkit/dldt
ln -sf /home/keya87/code/dldt/inference-engine/bin/intel64/Release/lib/ /opt/openvino_toolkit/deployment_tools/inference_engine/samples/build/intel64/Release

# Install Open Model Zoo
cd ~/code
git clone https://github.com/opencv/open_model_zoo.git
cd open_model_zoo/demos/
git checkout 2019
mkdir build && cd build
cmake -DCMAKE_BUILD_TYPE=Release /opt/openvino_toolkit/dldt/inference-engine -DENABLE_GNA=OFF -DENABLE_MKL_DNN=OFF
sudo make -j8
sudo mkdir -p /opt/openvino_toolkit
sudo ln -sf ~/code/open_model_zoo /opt/openvino_toolkit/open_model_zoo

# set ENV CPU_EXTENSION_LIB and GFLAGS_LIB
echo "export CPU_EXTENSION_LIB=$HOME/code/dldt/inference-engine/bin/intel64/Release/lib/libcpu_extension.so" >> ~/.bashrc
echo "export GFLAGS_LIB=$HOME/code/dldt/inference-engine/bin/intel64/Release/lib/libgflags_nothreads.a" >> ~/.bashrc
echo "export InferenceEngine_DIR=/opt/openvino_toolkit/dldt/inference-engine/build/" >> ~/.bashrc
echo "export OpenCV_DIR=$HOME/code/opencv/build" >> ~/.bashrc
echo "source ~/ros2_ws/install/local_setup.bash" >> ~/.bashrc


# Install ROS2_OpenVINO packages
mkdir -p ~/ros2_overlay_ws/src
cd ~/ros2_overlay_ws/src
git clone https://github.com/intel/ros2_openvino_toolkit -b devel
git clone https://github.com/intel/ros2_object_msgs
git clone https://github.com/ros-perception/vision_opencv -b ros2
git clone https://github.com/ros2/message_filters.git
git clone https://github.com/ros-perception/image_common.git -b ros2
git clone https://github.com/intel/ros2_intel_realsense.git
# Building and Installation the samples
echo "ROOT is required instead of sudo"
echo "Type sudo su and enter next commands"

echo "mkdir -p /root/code/dldt/inference-engine/bin/intel64/Release/"
echo "ln -sf /home/keya87/code/dldt/inference-engine/bin/intel64/Release/lib/ /root/code/dldt/inference-engine/bin/intel64/Release/"
echo "export InferenceEngine_DIR=/opt/openvino_toolkit/dldt/inference-engine/build/"
echo "export CPU_EXTENSION_LIB=$HOME/code/dldt/inference-engine/bin/intel64/Release/lib/libcpu_extension.so"
echo "export GFLAGS_LIB=$HOME/code/dldt/inference-engine/bin/intel64/Release/lib/libgflags_nothreads.a"
echo "export OpenCV_DIR=$HOME/code/opencv/build"

# Build package
echo "source ~/ros2_ws/install/local_setup.bash"
echo "source /opt/intel/openvino_*/bin/setupvars.sh"


# Workaround some headers from next package are needed for compile
# sudo apt-get install ros-crystal-librealsense2 ??

echo "cd ~/ros2_overlay_ws"
echo "colcon build --symlink-install"
echo "source ~/ros2_overlay_ws/install/local_setup.bash" >> ~/.bashrc


#PART 2
cd ~/ros2_overlay_ws
source ./install/local_setup.bash
sudo mkdir -p /opt/openvino_toolkit
sudo ln -sf ~/ros2_overlay_ws/src/ros2_openvino_toolkit /opt/openvino_toolkit/ros2_openvino_toolkit

sudo apt-get remove -y ros-crystal-librealsense2
# Workaround for creating missing test files
#sudo mkdir -p /home/keya87/ros2_ws/install/rviz_rendering_tests/share/rviz_rendering_tests/#ogre_media_resources/scripts
#sudo mkdir -p /home/keya87/ros2_ws/install/rviz_rendering_tests/share/rviz_rendering_tests/ogre_media_resources/meshes
#cp ~/ros2_ws/install/rviz_rendering_tests/share/rviz_rendering_tests/scripts/test /home/keya87/ros2_ws/install/rviz_rendering_tests/share/rviz_rendering_tests/ogre_media_resources/scripts
#cp ~/ros2_ws/install/rviz_rendering_tests/share/rviz_rendering_tests/meshes/test /home/keya87/ros2_ws/install/rviz_rendering_tests/share/rviz_rendering_tests/ogre_media_resources/meshes

# Running the Demo

#object segmentation model
cd /opt/intel/openvino_*/deployment_tools/model_optimizer/install_prerequisites
sudo ./install_prerequisites.sh
mkdir -p ~/Downloads/models
cd ~/Downloads/models
wget http://download.tensorflow.org/models/object_detection/mask_rcnn_inception_v2_coco_2018_01_28.tar.gz
tar -zxvf mask_rcnn_inception_v2_coco_2018_01_28.tar.gz
sudo chmod -R mask_rcnn_inception_v2_coco_2018_01_28
cd mask_rcnn_inception_v2_coco_2018_01_28
python3 /opt/intel/openvino_*/deployment_tools/model_optimizer/mo_tf.py --input_model frozen_inference_graph.pb --tensorflow_use_custom_operations_config /opt/intel/openvino_*/deployment_tools/model_optimizer/extensions/front/tf/mask_rcnn_support.json --tensorflow_object_detection_api_pipeline_config pipeline.config --reverse_input_channels --output_dir ./output/
sudo mkdir -p /opt/models
sudo ln -sf ~/Downloads/models/mask_rcnn_inception_v2_coco_2018_01_28 /opt/models/
#object detection model
cd /opt/intel/openvino_*/deployment_tools/tools/model_downloader
sudo python3 ./downloader.py --name mobilenet-ssd
#FP32 precision model
sudo python3 /opt/intel/openvino_*/deployment_tools/model_optimizer/mo.py --input_model /opt/intel/openvino_*/deployment_tools/tools/model_downloader/object_detection/common/mobilenet-ssd/caffe/mobilenet-ssd.caffemodel --output_dir /opt/intel/openvino_*/deployment_tools/toolsmodel_downloader/object_detection/common/mobilenet-ssd/caffe/output/FP32 --mean_values [127.5,127.5,127.5] --scale_values [127.5]
#FP16 precision model
sudo python3 /opt/intel/openvino_*/deployment_tools/model_optimizer/mo.py --input_model /opt/intel/openvino_*/deployment_tools/tools/model_downloader/object_detection/common/mobilenet-ssd/caffe/mobilenet-ssd.caffemodel --output_dir /opt/intel/openvino_*/deployment_tools/tools/model_downloader/object_detection/common/mobilenet-ssd/caffe/output/FP16 --data_type=FP16 --mean_values [127.5,127.5,127.5] --scale_values [127.5]

# copy label files (excute once)
sudo cp /opt/openvino_toolkit/ros2_openvino_toolkit/data/labels/emotions-recognition/FP32/emotions-recognition-retail-0003.labels /opt/intel/openvino_*/deployment_tools/intel_models/emotions-recognition-retail-0003/FP32
sudo cp /opt/openvino_toolkit/ros2_openvino_toolkit/data/labels/face_detection/face-detection-adas-0001.labels /opt/intel/openvino_*/deployment_tools/intel_models/face-detection-adas-0001/FP32
sudo cp /opt/openvino_toolkit/ros2_openvino_toolkit/data/labels/face_detection/face-detection-adas-0001.labels /opt/intel/openvino_*/deployment_tools/intel_models/face-detection-adas-0001/FP16
sudo cp /opt/openvino_toolkit/ros2_openvino_toolkit/data/labels/object_segmentation/frozen_inference_graph.labels ~/Downloads/models/mask_rcnn_inception_v2_coco_2018_01_28/output
sudo cp /opt/openvino_toolkit/ros2_openvino_toolkit/data/labels/object_detection/mobilenet-ssd.labels /opt/intel/openvino_*/deployment_tools/model_downloader/object_detection/common/mobilenet-ssd/caffe/output/FP32
sudo cp /opt/openvino_toolkit/ros2_openvino_toolkit/data/labels/object_detection/ssd300.labels /opt/intel/openvino_*/deployment_tools/model_downloader/object_detection/common/mobilenet-ssd/caffe/output/FP36

echo "/opt/intel/openvino_*/bin/setupvars.sh" >> ~/.bashrc
echo "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/intel/openvino_*/deployment_tools/inference_engine/samples/build/intel64/Release/lib" >> ~/.bashrc

echo "General setup completed"














