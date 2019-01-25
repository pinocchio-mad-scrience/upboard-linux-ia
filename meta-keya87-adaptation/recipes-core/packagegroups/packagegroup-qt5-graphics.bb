DESCRIPTION = "qt5 graphics"
LICENSE = "MIT"

inherit packagegroup

RDEPENDS_${PN} = " \
                 packagegroup-qt5-toolchain-target \
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
