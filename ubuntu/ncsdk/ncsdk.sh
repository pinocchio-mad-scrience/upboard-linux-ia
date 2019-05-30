#!/bin/bash




# Install boost compiled with gcc-5.5.0
sudo apt-get install cmake libblkid-dev e2fslibs-dev libboost-all-dev libaudit-dev
sudo apt-get install -y libusb-1.0-0-dev libprotobuf-dev libleveldb-dev libsnappy-dev libopencv-dev libhdf5-serial-dev protobuf-compiler libatlas-base-dev git automake byacc lsb-release cmake libgflags-dev libgoogle-glog-dev liblmdb-dev swig3.0 graphviz libxslt-dev libxml2-dev gfortran python3-dev python-pip python3-pip python3-setuptools python3-markdown python3-pillow python3-yaml python3-pygraphviz python3-h5py python3-nose python3-lxml python3-matplotlib python3-numpy python3-protobuf python3-dateutil python3-skimage python3-scipy python3-six python3-networkx python3-tk

cd $HOME/code
wget https://sourceforge.net/projects/boost/files/boost/1.62.0/boost_1_62_0.tar.gz
tar -xvf boost_1_62_0.tar.gz
cd boost_1_62_0
./bootstrap.sh --with-toolset=gcc --prefix=/usr/local
./b2 --toolset=gcc-5.5.0 ---with=all install

# Clone and install NCSDK
git clone https://github.com/movidius/ncsdk.git
git checkout 3ca1171b4237cc64e0388cb8633c2626baced59a
cd ncsdk
make install
make examples

echo "export PYTHONPATH="${PYTHONPATH}:/opt/movidius/caffe/python"" >> ~/.bashrc
