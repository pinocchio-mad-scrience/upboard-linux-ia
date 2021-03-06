DESCRIPTION = "qt5 graphics"
LICENSE = "MIT"

inherit packagegroup autotools

RDEPENDS_${PN} = " \
                 packagegroup-qt5-toolchain-target \
                 gstreamer1.0-libav \
                 qtbase \
                 qtbase-plugins \
                 qtbase-tools \
                 qtdeclarative \
                 qtdeclarative-qmlplugins \
                 qtmultimedia \
                 qtmultimedia-plugins \
                 qtquickcontrols \
                 qtquickcontrols2 \
                 qtgraphicaleffects \
"
# Development packages 
# Add if needed 
# qtbase-dev 
# qtbase-mkspecs 
# qtdeclarative-dev 
# qtdeclarative-mkspecs 
# qtmultimedia-dev 
# qtmultimedia-mkspecs 
