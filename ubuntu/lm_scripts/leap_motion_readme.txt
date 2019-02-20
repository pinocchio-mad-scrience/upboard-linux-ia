                       # Leap motion basic start and install information


A. Install application

1. Download Linux installer from https://www.leapmotion.com/setup/desktop/linux/
2. Copy to .sh file and .tgz file to a specific folder
3. sudo ./leap_modtion_setup.sh

# Note 
#Same steps apply to SDK Leap Motion Developer Linux Kit

# If you have issues with install dependencies please follow this link
# https://support.leapmotion.com/hc/en-us/articles/223782608-Linux-Installation


B. Run Application
On Ubuntu the Leap Daemon should already be running. You can then run:
LeapControlPanel
From there you can right-click the tray icon to get a drop-down menu with
various options.
To restart the daemon (if necessary), run:
sudo service leapd restart
On non-Ubuntu distros, if leapd is not installed as a service, you may run:
sudo leapd

To start the Leap Motion daemon, run:
  sudo leapd
This does not appear to be an Debian or Ubuntu-compatible distro
If you would like Leap Motion to run as a service, it is up to you
to configure systemd or /etc/init.d appropriately.
Open the Leap Motion GUI with:
  LeapControlPanel 
See /usr/share/Leap/README.linux for more information.

Advanced settings:

LeapControlPanel --showsettings

A. First, attempt the basic troubleshooting steps just like on Windows or Mac
OS X. Run:
sudo service leapd status
And check your cable, do not connect through a USB hub, verify that other
devices work through that same USB socket. If you can install Windows on
the same system, verify that the Windows version of the Leap Motion software
works on this system.

For more information consult the main distribuitor site:
https://support.leapmotion.com/hc/en-us/articles/223782608-Linux-Installation
