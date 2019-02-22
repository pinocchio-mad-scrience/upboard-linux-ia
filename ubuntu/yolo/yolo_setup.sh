#!/bin/bash 

# Credit for install dependencies
# https://www.learnopencv.com/installing-deep-learning-frameworks-on-ubuntu-with-cuda-support/

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
 
# If you have CUDA installed
pip install tensorflow-gpu 
 
pip install Theano 
pip install keras
pip install dlib

# Install PyTorch
# The version of Anaconda may be different depending on when you are installing`
curl -O https://repo.anaconda.com/archive/Anaconda3-5.2.0-Linux-x86_64.sh
sh Anaconda3-5.2.0-Linux-x86_64.sh
# and follow the prompts. The defaults are generally good.`


#deactivate
