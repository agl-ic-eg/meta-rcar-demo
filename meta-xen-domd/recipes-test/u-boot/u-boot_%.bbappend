FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = " \
    file://0001-net-rswitch-Add-missing-cache-invalidate-of-TX-descr.patch \
"

#    file://0001-HACK-Improve-large-file-download-via-TFTP.patch
