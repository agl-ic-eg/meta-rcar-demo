FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

# do_configure:append () {
#     cd ${S}
#     sed -i arch/arm64/boot/dts/renesas/xen-chosen.dtsi \
#         -e "s/loglvl=all/loglvl=info/"
# }
# 
