FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = "\
    file://boot-ufs.txt.${MACHINE} \
"

do_configure[noexec] = "1"
do_install[noexec] = "1"

do_compile:append() {
    uboot-mkimage -T script -d ${WORKDIR}/boot-ufs.txt.${MACHINE} ${B}/boot-ufs.uImage
}

do_deploy:append() {
    install -d ${DEPLOYDIR}
    install -m 0644 ${B}/boot-ufs.uImage ${DEPLOYDIR}/boot-ufs.uImage
}

