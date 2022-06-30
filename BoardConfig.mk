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
ifeq ($(WITH_GMS_TV),true)
BOARD_SYSTEMIMAGE_PARTITION_SIZE   := 2147483648
else
BOARD_SYSTEMIMAGE_PARTITION_SIZE   := 1616904192
endif
BOARD_VENDORIMAGE_PARTITION_SIZE   := 379584512
TARGET_USERIMAGES_USE_EXT4         := true
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE  := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_VENDOR             := vendor
BOARD_BUILD_SYSTEM_ROOT_IMAGE      := true

# Assert
TARGET_OTA_ASSERT_DEVICE := foster,darcy,jetson,loki,icosa,mdarcy
ifneq ($(WITH_GMS_TV),true)
TARGET_OTA_ASSERT_DEVICE := $(TARGET_OTA_ASSERT_DEVICE),sif
endif

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
TARGET_KERNEL_SOURCE           := kernel/nvidia/kernel-$(TARGET_TEGRA_KERNEL)
TARGET_KERNEL_CONFIG           := tegra_android_defconfig
TARGET_KERNEL_RECOVERY_CONFIG  := tegra_android_recovery_defconfig
BOARD_KERNEL_IMAGE_NAME        := Image.gz
TARGET_KERNEL_ADDITIONAL_FLAGS := "NV_BUILD_KERNEL_OPTIONS=$(TARGET_TEGRA_KERNEL)"

# Recovery
TARGET_RECOVERY_FSTAB        := device/nvidia/foster/initfiles/fstab.foster
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

# TWRP Support
ifeq ($(WITH_TWRP),true)
include device/nvidia/foster/twrp/twrp.mk
endif

include device/nvidia/t210-common/BoardConfigCommon.mk
