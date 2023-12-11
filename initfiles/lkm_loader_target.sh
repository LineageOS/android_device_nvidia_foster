#!/vendor/bin/sh

/vendor/bin/insmod /vendor/lib/modules/pci-tegra.ko

hardwareName=$(getprop ro.hardware)
if [ "`cat /proc/device-tree/brcmfmac_pcie_wlan/status`" = "okay" ]; then
  /vendor/bin/insmod /vendor/lib/modules/compat.ko
  /vendor/bin/insmod /vendor/lib/modules/cy_cfg80211.ko
  /vendor/bin/insmod /vendor/lib/modules/brcmutil.ko
  /vendor/bin/insmod /vendor/lib/modules/brcmfmac.ko
elif [ "`cat /proc/device-tree/bcmdhd_wlan/status`" = "okay" ]; then
  /vendor/bin/modprobe -a -d /vendor/lib/modules bcmdhd;
fi
if [[ "$hardwareName" = +(porg*) ]]; then
  /vendor/bin/modprobe -a -d /vendor/lib/modules btusb;
elif [[ "$hardwareName" = "batuu" ]]; then
  /vendor/bin/modprobe -a -d /vendor/lib/modules rtl8821cu;
fi
