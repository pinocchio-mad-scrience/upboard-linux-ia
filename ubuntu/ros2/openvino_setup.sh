#!/bin/bash 





cd /opt/intel/computer_vision_sdk/install_dependencies
sudo ./install_NEO_OCL_driver.sh

Adding keya87 to the video group...

Installation completed successfully.

Next steps:
Add OpenCL users to the video group: 'sudo usermod -a -G video USERNAME'
   e.g. if the user running OpenCL host applications is foo, run: sudo usermod -a -G video foo

Install 4.14 kernel using install_4_14_kernel.sh script and reboot into this kernel

If you use 8th Generation Intel® Core™ processor, you will need to add:
   i915.alpha_support=1
   to the 4.14 kernel command line, in order to enable OpenCL functionality for this platform.




