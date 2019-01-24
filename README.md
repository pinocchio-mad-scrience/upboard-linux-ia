Up board Yocto Community Intelligent Assistant

Personal Robot Assistant with Artificial Intelligence develop using Intel Robotics Dev Kit - AAEON UPBOARD

To get the project you need to have git clone the project:

#git clone https://github.com/pinocchio-mad-scrience/upboard-yocto-ia.git

A. To compile and build a simple image on Linux distribution from the source directory:

#export TEMPLATECONF=/home/[username]/[poky_dir]/prj-keya/conf 

#source setup-enviroment 

#bitbake core-image-minimal

B. To compile and build a full image on Linux distribution from the source directory:
#export TEMPLATECONF=/home/[username]/[poky_dir]/prj-keya/conf 

#bitbake upboard-image-sato

