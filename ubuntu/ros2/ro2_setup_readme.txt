                       #  Robot Operating System (ROS) basic start and install information

A. Install application

----------------IMPORTANT -----------------
On some boards setup will stuck you're system
Please also run next script in another terminal while running the setup

1. sudo $HOME/upboard-yocto-ia/ubuntu/upboard/tools/free_ram.sh -> first terminal
2. sudo ./ros2_setup.sh -> second terminal
3. If succesfull then "Complete install" will show in the end

# If you have issues with install dependencies please follow this link
# https://index.ros.org/doc/ros2/Installation/Linux-Development-Setup/

============================================================================
B. Try some examples

1. In one terminal, source the setup file and then run a talker:

. ~/ros2_ws/install/local_setup.bash ros2 run demo_nodes_cpp talker

2. In another terminal source the setup file and then run a listener:

. ~/ros2_ws/install/local_setup.bash ros2 run demo_nodes_py listener

3. Check simple example 
You should see the talker saying that it’s Publishing messages and the listener saying I heard those messages. Hooray!




