                       # RealSense basic start and install information


A. Install realsense application

sudo ./real_sense_setup.sh 

Linux Distribution
Using pre-build packages

Intel® RealSense™ SDK 2.0 provides installation packages in dpkg format for Ubuntu 16/18 LTS.
The Realsense DKMS kernel drivers package (librealsense2-dkms) supports Ubuntu LTS kernels 4.4, 4.10, 4.13 and 4.15. Please refer to Ubuntu Kernel Release Schedule for further details.
Configuring and building from the source code

While we strongly recommend to use DKMS package whenever possible, there are certain cases where installing and patching the system manually is necessary:

    Using SDK with linux kernel version 4.16+
    Integration of user-specific patches/modules with librealsense SDK.
    Adjusting the patches for alternative kernels/distributions.

The steps are described in Linux manual installation guide

# If you have issues with install dependencies please follow this link
# https://github.com/IntelRealSense/librealsense/blob/development/doc/distribution_linux.md
# https://github.com/intel-ros/realsense

B. Install SDK realsense application
----------------IMPORTANT -----------------
Save you're work because after this script wil end, it will reboot you're system
sudo ./SDK_real_sense_setup.sh


C. For Firmware update, follow next link instructions:
https://www.intel.com/content/dam/support/us/en/documents/emerging-technologies/intel-realsense-technology/Linux-RealSense-D400-DFU-Guide.pdf

D. Run Application

1. Reconnect the Intel RealSense depth camera and run: realsense-viewer to verify the installation.
2. Startup RVIZ

roscore & -> first terminal
rosrun rviz rviz -> second terminal

