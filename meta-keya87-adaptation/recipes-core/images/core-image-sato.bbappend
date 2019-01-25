IMAGE_LINGUAS = " "

LICENSE = "MIT"

IMAGE_INSTALL += " \
    packagegroup-utils \
    opkg \
    procps \
    iproute2 \
"

# X11 Font support
IMAGE_INSTALL_append = " \
                        fontconfig \
                        freetype \
                        fontconfig-utils \
"

# QT5 basic support packages
IMAGE_INSTALL_append = " \
                         packagegroup-qt5-graphics \
                         packagegroup-core-x11-base \
                         jpeg \
                         mesa \
                         mesa-demos \
                         xclock \
"

# X11 keyboard and mouse support
IMAGE_INSTALL_append = " xf86-input-keyboard xf86-input-mouse"

#PACKAGE_EXCLUDE = " \
#       neard \
#"
