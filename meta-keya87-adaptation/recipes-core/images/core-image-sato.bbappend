SUMMARY = " Intel Robotics Dev Kit - AAEON UPBOARD development image"

LICENSE = "MIT"

CREDIT = "https://github.com/jumpnow/meta-rpi/tree/rocko for image packages"

IMAGE_FEATURES += "package-management"
IMAGE_LINGUAS = "en-us"

IMAGE_INSTALL += " \
    packagegroup-utils \
    opkg \
    procps \
    iproute2 \
"

CORE_OS = " \
    kernel-modules \
    packagegroup-core-boot \
    tzdata \
"

WIFI_SUPPORT = " \
    iw \
    wireless-tools \
    wpa-supplicant \
"

DEV_SDK_INSTALL = " \
    binutils \
    binutils-symlinks \
    coreutils \
    cpp \
    cpp-symlinks \
    diffutils \
    file \
    g++ \
    g++-symlinks \
    gcc \
    gcc-symlinks \
    gdb \
    gdbserver \
    gettext \
    git \
    ldd \
    libstdc++ \
    libstdc++-dev \
    libtool \
    make \
    pkgconfig \
    python3-modules \
"
EXTRA_TOOLS_INSTALL = " \
    bzip2 \
    devmem2 \
    dosfstools \
    ethtool \
    fbset \
    findutils \
    i2c-tools \
    iperf3 \
    iproute2 \
    iptables \
    less \
    nano \
    procps \
    sysfsutils \
    unzip \
    util-linux \
    wget \
    zip \
"

IMAGE_INSTALL += " \
    ${CORE_OS} \
    ${DEV_SDK_INSTALL} \
    ${EXTRA_TOOLS_INSTALL} \
    ${WIFI_SUPPORT} \
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
         twm \
         xterm \
"

# X11 keyboard and mouse support
IMAGE_INSTALL_append = " xf86-input-keyboard xf86-input-mouse"

#PACKAGE_EXCLUDE = " \
#       neard \
#"
