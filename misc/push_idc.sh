#!/bin/bash

SCRIPT_DIR=$(cd `dirname $0` && pwd)
cd $SCRIPT_DIR

adb root
adb shell mkdir -p /data/system/devices/idc
adb push tablet.idc /data/system/devices/idc/Vendor_0627_Product_0003.idc
adb push tablet.idc /data/system/devices/idc/Vendor_0627_Product_0001.idc
adb push wacom_fhd.idc /data/system/devices/idc/Wacom_Penpartner_Pen.idc
adb shell chown system:system -R /data/system/devices
adb shell chmod 644 -R /data/system/devices/idc/*.idc
adb shell sync
adb reboot

