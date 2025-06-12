FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += "\
    file://vmq1.network \
"

FILES:${PN} += " \
    ${sysconfdir}/systemd/network/vmq1.network \
"

