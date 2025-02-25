FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

do_configure:append() {
    cd ${S}
    # delete rcar_sound node
    sed -i arch/arm64/boot/dts/renesas/r8a779*-domd.dts -e '/sound_card/,+2d'
}

