#!/vendor/bin/sh

hardwareName=$(getprop ro.hardware)
if [ "`cat /proc/device-tree/brcmfmac_pcie_wlan/status`" = "okay" ]; then
  /vendor/bin/modprobe -a -d /vendor/lib/modules brcmfmac;
elif [ "`cat /proc/device-tree/bcmdhd_wlan/status`" = "okay" ]; then
  /vendor/bin/modprobe -a -d /vendor/lib/modules bcmdhd;
fi
if [[ "$hardwareName" = +(porg*) ]]; then
  /vendor/bin/modprobe -a -d /vendor/lib/modules btusb;
elif [[ "$hardwareName" = "batuu" ]]; then
  /vendor/bin/modprobe -a -d /vendor/lib/modules rtl8821cu;
fi
