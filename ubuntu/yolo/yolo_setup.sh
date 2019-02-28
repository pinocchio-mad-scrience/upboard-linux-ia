#!/bin/bash 

# Credit for install dependencies
# https://github.com/vietnguyen91/Yolo-v2-pytorch.git
# https://www.learnopencv.com/installing-deep-learning-frameworks-on-ubuntu-with-cuda-support/
# https://pytorch.org/get-started/locally/ 

git clone https://github.com/vietnguyen91/Yolo-v2-pytorch.git
cd Yolo-v2-pytorch/
sudo apt-get install -y python3.6 build-essential cmake gfortran git pkg-config 
sudo apt-get install -y python-dev software-properties-common wget vim

# create a virtual environment for python 3
sudo pip3 install virtualenv virtualenvwrapper

echo "# Virtual Environment Wrapper"  >> ~/.bashrc
echo "source /usr/local/bin/virtualenvwrapper.sh" >> ~/.bashrc

echo "export WORKON_HOME=$HOME/code/.virtualenvs" >> ~/.bashrc
echo "export PROJECT_HOME=$HOME/code >>" ~/.bashrc
echo "export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python" ~/.bashrc
echo "export VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/bin/virtualenv" ~/.bashrc
echo "export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages'" ~/.bashrc

sudo ln -s /usr/bin/virtualenv /usr/local/bin/virtualenv

mkvirtualenv virtual-py3 -p python3
# Activate the virtual environment
workon virtual-py3
 
pip install numpy scipy matplotlib scikit-image scikit-learn ipython protobuf jupyter
 
# If you do not have CUDA installed
pip install tensorflow

pip install Theano 
pip install keras
pip install dlib
pip install https://download.pytorch.org/whl/cpu/torch-1.0.1.post2-cp36-cp36m-linux_x86_64.whl
pip install torchvision

deactivate

# Install OpenCV 3.3
sudo apt-get remove x264 libx264-dev
sudo apt-get install -y checkinstall yasm
sudo add-apt-repository "deb http://security.ubuntu.com/ubuntu xenial-security main"
sudo apt update
sudo apt list --upgradable
sudo apt install libjasper1 libjasper-dev
sudo apt-get install -y libjpeg8-dev libjasper-dev libpng-dev
sudo apt-get install -y libtiff5-dev
sudo apt-get install -y libavcodec-dev libavformat-dev libswscale-dev libdc1394-22-dev
sudo apt-get install -y libxine2-dev libv4l-dev
sudo apt-get install -y libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev
sudo apt-get install -y libqt4-dev libgtk2.0-dev libtbb-dev
sudo apt-get install -y libfaac-dev libmp3lame-dev libtheora-dev
sudo apt-get install -y libvorbis-dev libxvidcore-dev
sudo apt-get install -y libopencore-amrnb-dev libopencore-amrwb-dev
sudo apt-get install -y x264 v4l-utils
sudo snap install ffmpeg
sudo apt-get install -y ffmpeg


git clone https://github.com/opencv/opencv.git
cd opencv
git checkout 3.3.0
cd ..
git clone https://github.com/opencv/opencv_contrib.git
cd opencv_contrib
git checkout 3.3.0
cd ..
cd opencv 
mkdir build 

sudo cmake -D CMAKE_BUILD_TYPE=RELEASE \
      -D CMAKE_INSTALL_PREFIX=/usr/local \
      -D INSTALL_C_EXAMPLES=ON \
      -D INSTALL_PYTHON_EXAMPLES=ON \
      -D WITH_TBB=ON \
      -D WITH_V4L=ON \
      -D WITH_QT=ON \
      -D WITH_OPENGL=ON \
      -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
      -D BUILD_EXAMPLES=ON ..

sudo make -j4 
sudo make install
sudo sh -c 'echo "/usr/local/lib" >> /etc/ld.so.conf.d/opencv.conf'
sudo ldconfig




