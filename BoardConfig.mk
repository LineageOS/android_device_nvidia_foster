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
BOARD_VENDORIMAGE_PARTITION_SIZE   := 566231040
TARGET_USERIMAGES_USE_EXT4         := true
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE  := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_VENDOR             := vendor

# Assert
TARGET_OTA_ASSERT_DEVICE := foster,darcy,jetson,loki,mdarcy,nx

# Boot image
BOARD_CUSTOM_BOOTIMG    := true
BOARD_CUSTOM_BOOTIMG_MK := device/nvidia/foster/mkbootimg.mk
BOARD_MKBOOTIMG_ARGS    := --header_version 1

# Bootloader versions
TARGET_BOARD_INFO_FILE := device/nvidia/foster/board-info.txt

# Manifest
DEVICE_MANIFEST_FILE := device/nvidia/foster/manifest.xml

# Bluetooth
ifeq ($(TARGET_TEGRA_BT),bcm)
BOARD_CUSTOM_BT_CONFIG := device/nvidia/foster/comms/vnd_foster.txt
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/nvidia/foster/comms
endif

# Charger
WITH_LINEAGE_CHARGER := false

# Kernel
ifneq ($(TARGET_PREBUILT_KERNEL),)
BOARD_VENDOR_KERNEL_MODULES += $(wildcard $(dir $(TARGET_PREBUILT_KERNEL))/*.ko)
endif
TARGET_KERNEL_CLANG_COMPILE    := false
KERNEL_TOOLCHAIN               := $(shell pwd)/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-gnu-9.3/bin
KERNEL_TOOLCHAIN_PREFIX        := aarch64-buildroot-linux-gnu-
TARGET_KERNEL_SOURCE           := kernel/nvidia/kernel-$(TARGET_TEGRA_KERNEL)
TARGET_KERNEL_CONFIG           := tegra_android_defconfig
BOARD_KERNEL_CMDLINE           := androidboot.selinux=permissive
BOARD_KERNEL_IMAGE_NAME        := Image.gz
TARGET_KERNEL_ADDITIONAL_FLAGS := "NV_BUILD_KERNEL_OPTIONS=$(TARGET_TEGRA_KERNEL)"
BOARD_KERNEL_CMDLINE           := "androidboot.boot_devices=sdhci-tegra.0,tegra-sata.0,sdhci-tegra.3"
include device/nvidia/foster/modules.mk

# Recovery
TARGET_RECOVERY_FSTAB        := device/nvidia/foster/initfiles/fstab.emmc
TARGET_RECOVERY_UPDATER_LIBS := librecoveryupdater_tegra
TARGET_RECOVERY_PIXEL_FORMAT := BGRA_8888

# Releasetools
TARGET_RELEASETOOLS_EXTENSIONS := device/nvidia/foster/releasetools

# Security Patch Level
VENDOR_SECURITY_PATCH := 2022-04-05

# Treble
BOARD_PROPERTY_OVERRIDES_SPLIT_ENABLED := true
BOARD_VNDK_VERSION                     := current
PRODUCT_FULL_TREBLE_OVERRIDE           := true

# Verity
# Only needed for signing
BOARD_AVB_ENABLE := false

include device/nvidia/t210-common/BoardConfigCommon.mk
