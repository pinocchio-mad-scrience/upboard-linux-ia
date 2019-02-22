#!/bin/bash 

tar -zxf l_openvino_toolkit_p_*.tgz
cd l_openvino_toolkit_p_*/
sudo -E ./install_cv_sdk_dependencies.sh
sudo ./install.sh

cd /opt/intel/computer_vision_sdk/deployment_tools/model_optimizer/install_prerequisites
sudo ./install_prerequisites.sh
sudo ./install_prerequisites_tf.sh



