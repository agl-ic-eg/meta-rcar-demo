FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = " \
    file://vmq0.network \
    file://vmq1.network \
"

FILES:${PN}:append = " \
    ${sysconfdir}/systemd/network/vmq1.network \
"

do_install:append() {
    install -m 0644 ${S}/vmq1.network ${D}${sysconfdir}/systemd/network
}

