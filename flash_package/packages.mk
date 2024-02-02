# Copyright (C) 2021 The LineageOS Project
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

LOCAL_PATH := $(call my-dir)

FOSTER_BL       := $(BUILD_TOP)/vendor/nvidia/foster/rel-shield-r/bootloader
JETSON_BL       := $(BUILD_TOP)/vendor/nvidia/foster/r32/bootloader
TEGRAFLASH_PATH := $(BUILD_TOP)/vendor/nvidia/t210/r32/tegraflash
T210_BL         := $(BUILD_TOP)/vendor/nvidia/t210/r32/bootloader
FOSTER_BCT      := $(BUILD_TOP)/vendor/nvidia/foster/r32/BCT
FOSTER_FLASH    := $(BUILD_TOP)/device/nvidia/foster/flash_package
COMMON_FLASH    := $(BUILD_TOP)/device/nvidia/tegra-common/flash_package

TNSPEC_PY     := $(BUILD_TOP)/vendor/nvidia/common/rel-24/tegraflash/tnspec.py
FOSTER_TNSPEC := $(BUILD_TOP)/vendor/nvidia/foster/rel-30/tnspec/foster.json

INSTALLED_BMP_BLOB_TARGET      := $(PRODUCT_OUT)/bmp.blob
INSTALLED_KERNEL_TARGET        := $(PRODUCT_OUT)/kernel
INSTALLED_RECOVERYIMAGE_TARGET := $(PRODUCT_OUT)/recovery.img
INSTALLED_TOS_TARGET           := $(PRODUCT_OUT)/tos-mon-only.img

ifneq ($(filter 3.10 4.9, $(TARGET_TEGRA_KERNEL)),)
DTB_PATH := $(abspath $(KERNEL_OUT)/arch/arm64/boot/dts)
else ifneq ($(findstring dtstree,$(TARGET_KERNEL_ADDITIONAL_FLAGS)),)
DTB_PATH := $(abspath $(KERNEL_OUT)/../nv-oot/device-tree/platform/generic-dts/t21x/lineage)
else
DTB_PATH := $(abspath $(KERNEL_OUT)/arch/arm64/boot/dts/nvidia)
endif


include $(CLEAR_VARS)
LOCAL_MODULE        := p2371_flash_package
LOCAL_MODULE_SUFFIX := .txz
LOCAL_MODULE_CLASS  := ETC
LOCAL_MODULE_PATH   := $(PRODUCT_OUT)

_p2371_package_intermediates := $(call intermediates-dir-for,$(LOCAL_MODULE_CLASS),$(LOCAL_MODULE))
_p2371_package_archive := $(_p2371_package_intermediates)/$(LOCAL_MODULE)$(LOCAL_MODULE_SUFFIX)

$(_p2371_package_archive): $(INSTALLED_BMP_BLOB_TARGET) $(INSTALLED_KERNEL_TARGET) $(INSTALLED_RECOVERYIMAGE_TARGET) $(INSTALLED_TOS_TARGET)
	@mkdir -p $(dir $@)/tegraflash
	@mkdir -p $(dir $@)/scripts
	@cp $(TEGRAFLASH_PATH)/* $(dir $@)/tegraflash/
	@cp $(COMMON_FLASH)/*.sh $(dir $@)/scripts/
	@cp $(FOSTER_FLASH)/p2371.sh $(dir $@)/flash.sh
	@cp $(FOSTER_FLASH)/flash_t210_android_sdmmc_fb.xml $(dir $@)/
	@cp $(FOSTER_FLASH)/sign.xml $(dir $@)/
	@cp $(FOSTER_BL)/foster_e/*.bin $(dir $@)/
	@cp $(FOSTER_BL)/foster_e/rp4.blob $(dir $@)/
	@rm $(dir $@)/bpmp_zeroes.bin
	@cp $(T210_BL)/cboot.bin $(dir $@)/cboot_tegraflash.bin
	@cp $(T210_BL)/nvtboot_recovery.bin $(dir $@)/
	@cp $(INSTALLED_TOS_TARGET) $(dir $@)/
	@cp $(INSTALLED_BMP_BLOB_TARGET) $(dir $@)/
	@cp $(INSTALLED_RECOVERYIMAGE_TARGET) $(dir $@)/
	@cp $(JETSON_BL)/jetson_cv/tegra210-jetson-tx1-p2597-2180-a01-devkit.dtb $(dir $@)/
	@cp $(DTB_PATH)/tegra210-jetson-tx1-p2597-2180-a01-android-devkit.dtb $(dir $@)/
	@cp $(FOSTER_BCT)/P2180_A00_LP4_DSC_204Mhz.cfg $(dir $@)/
	@python2 $(TNSPEC_PY) nct new p2371-2180-devkit -o $(dir $@)/p2371-2180-devkit.bin --spec $(FOSTER_TNSPEC)
	@cd $(dir $@); tar -cJf $(abspath $@) *

include $(BUILD_SYSTEM)/base_rules.mk

include $(CLEAR_VARS)
LOCAL_MODULE        := baracus_flash_package
LOCAL_MODULE_SUFFIX := .txz
LOCAL_MODULE_CLASS  := ETC
LOCAL_MODULE_PATH   := $(PRODUCT_OUT)

_baracus_package_intermediates := $(call intermediates-dir-for,$(LOCAL_MODULE_CLASS),$(LOCAL_MODULE))
_baracus_package_archive := $(_baracus_package_intermediates)/$(LOCAL_MODULE)$(LOCAL_MODULE_SUFFIX)

$(_baracus_package_archive): $(INSTALLED_BMP_BLOB_TARGET) $(INSTALLED_KERNEL_TARGET) $(INSTALLED_RECOVERYIMAGE_TARGET) $(INSTALLED_TOS_TARGET)
	@mkdir -p $(dir $@)/tegraflash
	@mkdir -p $(dir $@)/scripts
	@cp $(TEGRAFLASH_PATH)/* $(dir $@)/tegraflash/
	@cp $(COMMON_FLASH)/*.sh $(dir $@)/scripts/
	@cp $(FOSTER_FLASH)/p2371.sh $(dir $@)/flash.sh
	@cp $(FOSTER_FLASH)/flash_t210_android_sdmmc_fb.xml $(dir $@)/
	@cp $(FOSTER_FLASH)/sign.xml $(dir $@)/
	@cp $(FOSTER_BL)/foster_e/*.bin $(dir $@)/
	@cp $(FOSTER_BL)/foster_e/rp4.blob $(dir $@)/
	@rm $(dir $@)/bpmp_zeroes.bin
	@cp $(T210_BL)/cboot.bin $(dir $@)/cboot_tegraflash.bin
	@cp $(T210_BL)/nvtboot_recovery.bin $(dir $@)/
	@cp $(INSTALLED_TOS_TARGET) $(dir $@)/
	@cp $(INSTALLED_BMP_BLOB_TARGET) $(dir $@)/
	@cp $(INSTALLED_RECOVERYIMAGE_TARGET) $(dir $@)/
	@cp $(JETSON_BL)/jetson_cv/tegra210-jetson-tx1-p2597-2180-a01-devkit.dtb $(dir $@)/
	@cp $(DTB_PATH)/tegra210-baracus.dtb $(dir $@)/tegra210-jetson-tx1-p2597-2180-a01-android-devkit.dtb
	@cp $(FOSTER_BCT)/P2180_A00_LP4_DSC_204Mhz.cfg $(dir $@)/
	@python2 $(TNSPEC_PY) nct new p2371-2180-4k-edp -o $(dir $@)/p2371-2180-devkit.bin --spec $(FOSTER_TNSPEC)
	@cd $(dir $@); tar -cJf $(abspath $@) *

include $(BUILD_SYSTEM)/base_rules.mk
