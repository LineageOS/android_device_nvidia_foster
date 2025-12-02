# Copyright (C) 2021-2024 The LineageOS Project
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

ifeq ($(TARGET_REFERENCE_DEVICE), foster)
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
INSTALLED_TOS_TARGET           := $(PRODUCT_OUT)/tos-$(if $(filter-out default,$(TARGET_SECURITY_KEYMINT_HAL)),$(TARGET_SECURITY_KEYMINT_HAL),mon-only).img

ifneq ($(TARGET_PREBUILT_KERNEL),)
DTB_PATH := $(dir $(TARGET_PREBUILT_KERNEL))
else ifneq ($(TARGET_KERNEL_PLATFORM_TARGET),)
DTB_PATH := $(abspath $(KERNEL_OUT))
endif


_p2371_package_archive := $(call intermediates-dir-for,ETC,p2371_flash_package)/p2371_flash_package.txz

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
	@rm $(dir $@)/bpmp_zeroes.bin $(dir $@)/nvtboot.bin
	@cp $(FOSTER_BL)/jetson_cv/nvtboot.bin $(dir $@)/
	@cp $(T210_BL)/cboot.bin $(dir $@)/cboot_tegraflash.bin
	@cp $(T210_BL)/nvtboot_recovery.bin $(dir $@)/
	@cp $(INSTALLED_TOS_TARGET) $(dir $@)/tos.img
	@cp $(FOSTER_FLASH)/eks_nokey.dat $(dir $@)/eks.img
	@cp $(INSTALLED_BMP_BLOB_TARGET) $(dir $@)/
	@cp $(INSTALLED_RECOVERYIMAGE_TARGET) $(dir $@)/
	@cp $(JETSON_BL)/jetson_cv/tegra210-jetson-tx1-p2597-2180-a01-devkit.dtb $(dir $@)/
	@cp $(DTB_PATH)/tegra210-jetson-tx1-p2597-2180-a01-android-devkit.dtb $(dir $@)/
	@cp $(FOSTER_BCT)/P2180_A00_LP4_DSC_204Mhz.cfg $(dir $@)/
	@python3 $(TNSPEC_PY) nct new p2371-2180-devkit -o $(dir $@)/p2371-2180-devkit.bin --spec $(FOSTER_TNSPEC)
	@cd $(dir $@); tar -cJf $(abspath $@) *

$(PRODUCT_OUT)/p2371_flash_package.txz: $(_p2371_package_archive)
	$(hide) cp $< $@

.PHONY: p2371_flash_package
p2371_flash_package: $(PRODUCT_OUT)/p2371_flash_package.txz


ifeq ($(word 2,$(subst _, ,$(TARGET_PRODUCT))),foster)
BUILT_TARGET_FILES_ZIPROOT := $(call intermediates-dir-for,PACKAGING,target_files)/$(TARGET_PRODUCT)-target_files
$(BUILT_TARGET_FILES_ZIPROOT).zip: $(BUILT_TARGET_FILES_ZIPROOT)/IMAGES/p2371_flash_package.txz

$(BUILT_TARGET_FILES_ZIPROOT)/IMAGES/p2371_flash_package.txz: $(BUILT_TARGET_FILES_ZIPROOT).zip.list $(PRODUCT_OUT)/p2371_flash_package.txz
	@mkdir -p $(dir $@)
	@cp $(PRODUCT_OUT)/p2371_flash_package.txz $@
	@echo $@ >> $(BUILT_TARGET_FILES_ZIPROOT).zip.list
endif
endif
