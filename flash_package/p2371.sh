#!/bin/bash

PATH=$(pwd)/tegraflash:${PATH}

TARGET_TEGRA_VERSION=t210;
TARGET_MODULE_ID=2180;
#TARGET_CARRIER_ID=2597;
TARGET_CARRIER_ID=;

source $(pwd)/scripts/helpers.sh;

declare -a FLASH_CMD_EEPROM=(
  --applet nvtboot_recovery.bin
  --chip 0x21);

if ! get_interfaces; then
  exit -1;
fi;

if ! check_compatibility ${TARGET_MODULE_ID} ${TARGET_CARRIER_ID}; then
  echo "No Jetson TX1 module found";
  exit -1;
fi;

# Sign some images
echo "Signing boot images";
cp tegra210-jetson-tx1-p2597-2180-a01-android-devkit.dtb temp.dtb > /dev/null
cp cboot_tegraflash.bin cboot.tmp > /dev/null
tegraflash.py \
  "${FLASH_CMD_EEPROM[@]}" \
  --bct P2180_A00_LP4_DSC_204Mhz.cfg \
  --instance ${INTERFACE} \
  --cfg sign.xml \
  --cmd "sign" \
  > /dev/null
cp signed/temp.dtb.encrypt . > /dev/null
cp signed/cboot.tmp.encrypt . > /dev/null
rm -rf signed cboot.tmp temp.dtb > /dev/null

declare -a FLASH_CMD_FLASH=(
  ${FLASH_CMD_EEPROM[@]}
  --bl cboot.tmp.encrypt
  --odmdata 0x94000
  --bct P2180_A00_LP4_DSC_204Mhz.cfg \
  --bldtb temp.dtb.encrypt
  --nct p2371-2180-devkit.bin)

tegraflash.py \
  "${FLASH_CMD_FLASH[@]}" \
  --instance ${INTERFACE} \
  --cfg flash_t210_android_sdmmc_fb.xml \
  --cmd "flash; reboot"

rm -f temp.dtb.encrypt cboot.tmp.encrypt > /dev/null
