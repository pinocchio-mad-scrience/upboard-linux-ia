IMAGE_LINGUAS = " "

LICENSE = "MIT"

IMAGE_INSTALL += " \
    packagegroup-utils \
    opkg \
    procps \
    iproute2 \
"


PACKAGE_EXCLUDE = " \
       neard \
"
