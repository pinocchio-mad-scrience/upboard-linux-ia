FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

COMPATIBLE_MACHINE = "(genericx86-64)"

LINUX_VERSION_EXTENSION = "-${MACHINE}"

PACKAGE_ARCH = "${MACHINE_ARCH}"

KMACHINE_aaeron_upboard = "genericx86-64"

SRC_URI_append                 += " \
                               file://atom.cfg \
                               file://keya-87-general-config.cfg \
                               file://cfg/upboard_features.cfg \
"

# System Trace Module and Intel Trace Hub
SRC_URI_append_${MACHINE} += " \
        file://cfg/stm.cfg \
        file://cfg/ith.cfg \
"

# Firewall and routing support 
SRC_URI_append_${MACHINE} += " \
        file://cfg/firewall_features.cfg \
"

# IEEE 802,1Q VLAN
SRC_URI_append_${MACHINE} += " \
		file://cfg/vlan_features.cfg \
"

# IPSec
SRC_URI_append_${MACHINE} += " \
		file://cfg/ipsec_features.cfg \
"

# Kernel debugging tools and features
SRC_URI_append_${MACHINE} += " \
		file://cfg/kernel_debug.cfg \
"

# WIFI support
SRC_URI_append_${MACHINE} += " \
                file://cfg/wireless_feature.cfg \
"

# LEVELS:
#   0: no reporting
#   1: report options that are specified, but not in the final config
#   2: report options that are not hardware related, but set by a BSP
KCONF_AUDIT_LEVEL ?= "1"
