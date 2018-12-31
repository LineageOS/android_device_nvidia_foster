#
# Copyright (C) 2018 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

BOARD_FLASH_BLOCK_SIZE             := 4096
BOARD_BOOTIMAGE_PARTITION_SIZE     := 26738688
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 26767360
BOARD_CACHEIMAGE_PARTITION_SIZE    := 268435456
BOARD_USERDATAIMAGE_PARTITION_SIZE := 10099646976
BOARD_SYSTEMIMAGE_PARTITION_SIZE   := 2147483648
BOARD_VENDORIMAGE_PARTITION_SIZE   := 805306368
TARGET_USERIMAGES_USE_EXT4         := true
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_VENDOR             := vendor

# Assert
TARGET_OTA_ASSERT_DEVICE := foster,darcy,sif,jetson,loki

# Bootloader versions
TARGET_BOARD_INFO_FILE := device/nvidia/foster/board-info.txt

# Bluetooth
BOARD_HAVE_BLUETOOTH     := true
BOARD_HAVE_BLUETOOTH_BCM := true
BOARD_CUSTOM_BT_CONFIG   := device/nvidia/foster/comms/vnd_foster.txt
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/nvidia/foster/comms

# Kernel
KERNEL_TOOLCHAIN        := $(shell pwd)/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-gnu-6.4.1/bin
KERNEL_TOOLCHAIN_PREFIX := aarch64-linux-gnu-
TARGET_KERNEL_SOURCE    := kernel/nvidia/linux-4.9/kernel/kernel-4.9
TARGET_KERNEL_CONFIG    := tegra_android_defconfig
BOARD_KERNEL_IMAGE_NAME := zImage

# Lineage Hardware Support
JAVA_SOURCE_OVERLAYS := org.lineageos.hardware|device/nvidia/foster/lineagehw|**/*.java

# Manifest
DEVICE_MANIFEST_FILE := device/nvidia/foster/manifest.xml

# Recovery
TARGET_RECOVERY_FSTAB    := device/nvidia/foster/initfiles/fstab.foster
BOARD_SUPPRESS_EMMC_WIPE := true

# Releasetools
TARGET_RELEASETOOLS_EXTENSIONS := device/nvidia/foster/releasetools

# Security Patch Level
VENDOR_SECURITY_PATCH := 2018-12-05

# TWRP Support
ifeq ($(WITH_TWRP),true)
include device/nvidia/foster/twrp/twrp.mk
endif

# Vendor Init
TARGET_INIT_VENDOR_LIB := libinit_tegra libinit_shield libinit_foster

# Wifi
BOARD_WPA_SUPPLICANT_DRIVER      := NL80211
WPA_SUPPLICANT_VERSION           := VER_0_8_X
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_bcmdhd
BOARD_WLAN_DEVICE                := bcmdhd
BOARD_HOSTAPD_DRIVER             := NL80211
BOARD_HOSTAPD_PRIVATE_LIB        := lib_driver_cmd_bcmdhd
WIFI_DRIVER_FW_PATH_STA          := "/vendor/firmware/fw_bcmdhd.bin"
WIFI_DRIVER_FW_PATH_AP           := "/vendor/firmware/fw_bcmdhd.bin"
WIFI_DRIVER_FW_PATH_P2P          := "/vendor/firmware/fw_bcmdhd.bin"
WIFI_DRIVER_FW_PATH_PARAM        := "/sys/module/bcmdhd/parameters/firmware_path"
WIFI_DRIVER_MODULE_ARG           := "iface_name=wlan0"
WIFI_DRIVER_MODULE_NAME          := "bcmdhd"

include device/nvidia/t210-common/BoardConfigCommon.mk
include device/nvidia/touch/BoardConfigTouch.mk
