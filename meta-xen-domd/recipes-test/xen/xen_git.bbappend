FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = " \
    file://test.cfg \
"
#    file://0001-DEBUG.patch \
#    file://0001-DEBUG2.patch # not worked

do_configure:append () {
    cd ${S}
    # Remove 3sec delay
    sed -i xen/common/warning.c \
        -e '/for ( i = 0; i < 3; i++ )/,+9d' \
        -e 's/, j//'
}

