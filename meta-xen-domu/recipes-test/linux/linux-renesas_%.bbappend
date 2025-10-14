FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = " \
    file://xen_wdt.cfg \
    file://0001-net-renesas-rswitch-proactively-schedule-NAPI-when-s.patch \
"

