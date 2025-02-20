# Android 15 on Xen with AGL reference cluster

## Disclaimer

This is not perfect guide, just a memo as of now.
If you need step by step guide, this is not suitable.
But, this may helps some experts and me in the future.

## Env

- HW
  - R-Car H3 evaluation board(Note: 4GB model is not supported)
    - HDMI0: Onlap touchpanel
    - HDMI1: Monitor(FHD recomended because reference cluster fixed to FHD)
- SW
  - Base
    - https://github.com/xen-troops/meta-xt-prod-devel-rcar
  - Additional for Demo
    - layers/meta-xxx
    - demo.yaml
- Target board list
  - H3SK + CCPF-SK
  - H3SK + Kingfisher
  - Salvator-XS with H3

## How to build

- git clone https://github.com/yhamamachi/meta-rcar-demo -b android_on_xen_with_agl_cluster_v1
- Copy GFX/MMP evaluation package into proprietary directory.
  - You can donload from following link
    - https://www.renesas.com/application/automotive/r-car-h3-m3-h2-m2-e2-documents-software
- Then, run build_xen_doma_agl_cluster.sh <board_name>
  - Run build_xen_doma_alg_cluster.sh without argument to see usage
  - If build is success, firmware directory and full.img.gz are stored into meta-xt-\* directory.

```
Directory structure:
|--build_xen_doma_agl_cluster.sh
|--demo.yaml
|--layers/
|--proprietary/
   |--R-Car_Gen3_Series_Evaluation_Software_Package_for_Linux-20220121.zip
   |--R-Car_Gen3_Series_Evaluation_Software_Package_of_Linux_Drivers-20220121.zip
```

## How to setup the demo

1. Flash firmware to board.
   - I recomend to use https://github.com/morimoto/renesas-bsp-rom-writer. This is useful for flashing firmware.
2. Setup U-boot
   - See also https://github.com/xen-troops/meta-xt-prod-devel-rcar/blob/master/doc/u-boot-env.md
   - Execute following command to setup U-Boot environment variable(XXX is according to your environment).
```
env default -a
setenv ipaddr 192.168.XXX.XXX
setenv serverip 192.168.XXX.XXX
setenv ethaddr '2e:09:0a:XX:XX:XX'
setenv flash_xen_emmc 'tftp 0x500000000 full.img.gz; gzwrite mmc 1 0x500000000 ${filesize} 400000 0'
saveenv
```
3. Flash full.img.gz into eMMC
   -  Setup TFTP server on your Host PC and copy full.img.gz into tftp root directory.
   - After setup network config on the board, execute 'run flash_xen_emmc' on U-Boot.

## How to run Demo

- Just power on.
  - Note: Af first booting, DomA will be rebooted automatically. This is for push idc files to fix issue touchscreen axis.

### Screenshot(upper side is DomA, bottom side is DomD)

![](screenshot.jpg)

