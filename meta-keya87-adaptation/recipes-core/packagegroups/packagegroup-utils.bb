DESCRIPTION = "The minimum set of packages required for the development image"
LICENSE = "MIT"

inherit packagegroup autotools

RDEPENDS_${PN} = "\
    kernel-devsrc \
    binutils \
    gcc \
    python-dev \
    cmake \
    make \
"
