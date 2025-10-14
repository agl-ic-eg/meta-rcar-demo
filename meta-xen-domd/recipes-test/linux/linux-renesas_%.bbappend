FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = " \
    file://xen_wdt.cfg \
    file://contig-pagecache.patch \
"

# do_configure:append () {
#     cd ${S}
#     sed -i arch/arm64/boot/dts/renesas/xen-chosen.dtsi \
#         -e "s/loglvl=all/loglvl=info/"
# }
# 
