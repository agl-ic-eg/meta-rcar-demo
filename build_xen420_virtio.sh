#!/bin/bash -eu

SCRIPT_DIR=$(cd `dirname $0` && pwd)
WORK_DIR=${SCRIPT_DIR}/build_xen420_virtio

mkdir -p ${WORK_DIR}
cd ${WORK_DIR}
# wget -c https://github.com/xen-troops/meta-xt-prod-devel-rcar-gen4/raw/refs/heads/spider-1.3.2%2B4.19/prod-devel-rcar-s4.yaml
#wget -c https://github.com/LKomaryanskiy/meta-xt-prod-devel-rcar-gen4/raw/refs/heads/spider-1.3.2-benchmarking/prod-devel-rcar-s4.yaml
#wget -c https://github.com/LKomaryanskiy/meta-xt-prod-devel-rcar-gen4/raw/refs/heads/spider-1.3.2-benchmarking-rc1/prod-devel-rcar-s4.yaml
#wget -c https://github.com/LKomaryanskiy/meta-xt-prod-devel-rcar-gen4/raw/refs/heads/spider-1.3.2-benchmarking-rc1-debug/prod-devel-rcar-s4.yaml
#wget -c https://github.com/LKomaryanskiy/meta-xt-prod-devel-rcar-gen4/raw/refs/heads/spider-1.3.2-benchmarking-rc2/prod-devel-rcar-s4.yaml
#wget -c https://github.com/LKomaryanskiy/meta-xt-prod-devel-rcar-gen4/raw/refs/heads/spider-1.3.2-benchmarking-multi-vm-rc1/prod-devel-rcar-s4.yaml
wget -c https://github.com/LKomaryanskiy/meta-xt-prod-devel-rcar-gen4/raw/refs/heads/spider-1.3.2-benchmarking-multi-vm-rc1/prod-devel-rcar-s4.yaml
# moulin prod-devel-rcar-s4.yaml --ENABLE_DOMU yes
cat prod-devel-rcar-s4.yaml ${SCRIPT_DIR}/patch.yaml > prod-devel-rcar-s4-new.yaml
sed -i "s/spider-1.3.2-benchmarking/spider-1.3.2-benchmarking-multi-vm-rc1/" prod-devel-rcar-s4-new.yaml
moulin prod-devel-rcar-s4-new.yaml --ENABLE_DOMU yes --ADD_META_TEST yes --DOMU_ROOTFS_RESIZE yes --CHANGE_KERNER_VER yes --DOMU_ROOTFS_DUPLICATE yes --USING_UFS_AS_STORAGE no

find ../common_data/sstate | grep boot-script: | xargs rm -r || true

ninja fetch-domd

# Change to use xen 4.19 instaed of 4.20-unstable
# cat << EOS > yocto/meta-xt-prod-devel-rcar-gen4/meta-xt-domx-gen4/recipes-extended/xen/xen-source.inc
# SRC_URI = "git://github.com/xen-troops/xen.git;protocol=https;branch=xen-4.19-xt0.2"
# XEN_REL = "4.19"
# XEN_REV = "8d17019373ad2d0928dfe9ce1ee4e3805209fc6c"
# LIC_FILES_CHKSUM = "file://COPYING;md5=d1a1e216f80b6d8da95fec897d0dbec9"
# EOS
# sed -i yocto/meta-xt-prod-devel-rcar-gen4/meta-xt-domx-gen4/recipes-extended/xen/xen-tools_git.bbappend -e 's/^SYSTEMD_SERVICE:${PN}-pcid/#SYSTEMD_SERVICE:${PN}-pcid/'

cat << EOS > yocto/meta-xt-prod-devel-rcar-gen4/meta-xt-driver-domain-gen4/recipes-connectivity/xen-network/files/tsn0.network
[Match]
Name=tsn0
#KernelCommandLine=ip=dhcp
[Network]
#DHCP=yes
Address=192.168.10.50
[DHCP]
CriticalConnection=true
EOS

ninja
ninja image-full
gzip -f full.img

