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

FOSTER_BL  := $(BUILD_TOP)/vendor/nvidia/foster/rel-shield-r/bootloader

TEGRAFLASH_PATH := $(BUILD_TOP)/vendor/nvidia/t210/r32/tegraflash
T210_BL         := $(BUILD_TOP)/vendor/nvidia/t210/r32/bootloader
FOSTER_BCT      := $(BUILD_TOP)/vendor/nvidia/foster/r32/BCT
FOSTER_FLASH    := $(BUILD_TOP)/device/nvidia/foster/flash_package

INSTALLED_KERNEL_TARGET := $(PRODUCT_OUT)/kernel
INSTALLED_TOS_TARGET    := $(PRODUCT_OUT)/tos-mon-only.img

TOYBOX_HOST := $(HOST_OUT_EXECUTABLES)/toybox
NVBLOB_HOST := python2 $(BUILD_TOP)/vendor/nvidia/foster/rel-30/bootloader/nvblob_v2

ifneq ($(TARGET_TEGRA_KERNEL),4.9)
DTB_SUBFOLDER := nvidia/
endif

include $(CLEAR_VARS)
LOCAL_MODULE        := darcy.blob
LOCAL_MODULE_CLASS  := ETC
LOCAL_MODULE_PATH   := $(PRODUCT_OUT)

_darcy_blob_intermediates := $(call intermediates-dir-for,$(LOCAL_MODULE_CLASS),$(LOCAL_MODULE))
_darcy_blob := $(_darcy_blob_intermediates)/$(LOCAL_MODULE)$(LOCAL_MODULE_SUFFIX)

$(_darcy_blob):
	@mkdir -p $(dir $@)
	OUT=$(dir $@) TOP=$(BUILD_TOP) $(NVBLOB_HOST) -t update \
		$(FOSTER_BL)/darcy/rp4.blob RP4 2 \
		$(FOSTER_BL)/darcy/tegra210-darcy-p2894-0000-a00-00.dtb RP1 2 \
		$(FOSTER_BL)/darcy/tegra210-darcy-p2894-0050-a04-00.dtb RP1 2 \
		$(FOSTER_BL)/darcy/tegra210-darcy-p2894-0050-a08-00.dtb RP1 2 \
		$(FOSTER_BL)/darcy/tegra210-darcy-p2894-0052-a08-00.dtb RP1 2 \
		$(FOSTER_BL)/darcy/cboot.bin EBT 2 \
		$(FOSTER_BL)/darcy/cboot.bin RBL 2 \
		$(FOSTER_BL)/foster_e/bpmp_zeroes.bin BPF 2 \
		$(FOSTER_BL)/darcy/nvtboot.bin NVC 2 \
		$(FOSTER_BL)/darcy/nvtboot.bin NVC-B 2 \
		$(FOSTER_BL)/darcy/nvtboot_cpu.bin TBC 2 \
		$(FOSTER_BL)/darcy/nvtboot_cpu.bin TBC-B 2 \
		$(FOSTER_BL)/darcy/warmboot.bin WB0 2 \
		$(FOSTER_BL)/darcy/tos.img TOS 2 \
		$(FOSTER_BL)/darcy/darcy.bct BCT 2
	@mv $(dir $@)/ota.blob $@

include $(BUILD_SYSTEM)/base_rules.mk
INSTALLED_RADIOIMAGE_TARGET += $(PRODUCT_OUT)/$(notdir $(_darcy_blob))

include $(CLEAR_VARS)
LOCAL_MODULE        := foster_e.blob
LOCAL_MODULE_CLASS  := ETC
LOCAL_MODULE_PATH   := $(PRODUCT_OUT)

_foster_e_blob_intermediates := $(call intermediates-dir-for,$(LOCAL_MODULE_CLASS),$(LOCAL_MODULE))
_foster_e_blob := $(_foster_e_blob_intermediates)/$(LOCAL_MODULE)$(LOCAL_MODULE_SUFFIX)

$(_foster_e_blob): $(INSTALLED_KERNEL_TARGET)
	@mkdir -p $(dir $@)
	OUT=$(dir $@) TOP=$(BUILD_TOP) $(NVBLOB_HOST) -t update \
		$(FOSTER_BL)/foster_e/rp4.blob RP4 2 \
		$(FOSTER_BL)/foster_e/tegra210-foster-e-p2530-0930-e01-00.dtb RP1 2 \
		$(FOSTER_BL)/foster_e/tegra210-foster-e-p2530-0930-e02-00.dtb RP1 2 \
		$(KERNEL_OUT)/arch/arm64/boot/dts/$(DTB_SUBFOLDER)tegra210-foster-e-p2530-0930-e01-00.dtb DTB 2 \
		$(KERNEL_OUT)/arch/arm64/boot/dts/$(DTB_SUBFOLDER)tegra210-foster-e-p2530-0930-e02-00.dtb DTB 2 \
		$(FOSTER_BL)/foster_e/cboot.bin EBT 2 \
		$(FOSTER_BL)/foster_e/cboot.bin RBL 2 \
		$(FOSTER_BL)/foster_e/bpmp_zeroes.bin BPF 2 \
		$(FOSTER_BL)/foster_e/nvtboot.bin NVC 2 \
		$(FOSTER_BL)/foster_e/nvtboot.bin NVC-B 2 \
		$(FOSTER_BL)/foster_e/nvtboot_cpu.bin TBC 2 \
		$(FOSTER_BL)/foster_e/nvtboot_cpu.bin TBC-B 2 \
		$(FOSTER_BL)/foster_e/warmboot.bin WB0 2 \
		$(FOSTER_BL)/foster_e/tos.img TOS 2 \
		$(FOSTER_BL)/foster_e/foster_e.bct BCT 2
	@mv $(dir $@)/ota.blob $@

include $(BUILD_SYSTEM)/base_rules.mk
ifeq ($(TARGET_PREBUILT_KERNEL),)
INSTALLED_RADIOIMAGE_TARGET += $(PRODUCT_OUT)/$(notdir $(_foster_e_blob))
endif

include $(CLEAR_VARS)
LOCAL_MODULE        := foster_e_hdd.blob
LOCAL_MODULE_CLASS  := ETC
LOCAL_MODULE_PATH   := $(PRODUCT_OUT)

_foster_e_hdd_blob_intermediates := $(call intermediates-dir-for,$(LOCAL_MODULE_CLASS),$(LOCAL_MODULE))
_foster_e_hdd_blob := $(_foster_e_hdd_blob_intermediates)/$(LOCAL_MODULE)$(LOCAL_MODULE_SUFFIX)

$(_foster_e_hdd_blob): $(INSTALLED_KERNEL_TARGET)
	@mkdir -p $(dir $@)
	OUT=$(dir $@) TOP=$(BUILD_TOP) $(NVBLOB_HOST) -t update \
		$(FOSTER_BL)/foster_e/rp4.blob RP4 2 \
		$(FOSTER_BL)/foster_e_hdd/tegra210-foster-e-hdd-cpc-p2530-0933-e03-00.dtb RP1 2 \
		$(FOSTER_BL)/foster_e_hdd/tegra210-foster-e-hdd-p2530-0932-e01-00.dtb RP1 2 \
		$(FOSTER_BL)/foster_e_hdd/tegra210-foster-e-hdd-p2530-0932-e02-00.dtb RP1 2 \
		$(KERNEL_OUT)/arch/arm64/boot/dts/$(DTB_SUBFOLDER)tegra210-foster-e-hdd-cpc-p2530-0933-e03-00.dtb DTB 2 \
		$(KERNEL_OUT)/arch/arm64/boot/dts/$(DTB_SUBFOLDER)tegra210-foster-e-hdd-p2530-0932-e01-00.dtb DTB 2 \
		$(KERNEL_OUT)/arch/arm64/boot/dts/$(DTB_SUBFOLDER)tegra210-foster-e-hdd-p2530-0932-e02-00.dtb DTB 2 \
		$(FOSTER_BL)/foster_e/cboot.bin EBT 2 \
		$(FOSTER_BL)/foster_e/cboot.bin RBL 2 \
		$(FOSTER_BL)/foster_e/bpmp_zeroes.bin BPF 2 \
		$(FOSTER_BL)/foster_e/nvtboot.bin NVC 2 \
		$(FOSTER_BL)/foster_e/nvtboot.bin NVC-B 2 \
		$(FOSTER_BL)/foster_e_hdd/nvtboot_cpu.bin TBC 2 \
		$(FOSTER_BL)/foster_e_hdd/nvtboot_cpu.bin TBC-B 2 \
		$(FOSTER_BL)/foster_e/warmboot.bin WB0 2 \
		$(FOSTER_BL)/foster_e_hdd/tos.img TOS 2 \
		$(FOSTER_BL)/foster_e_hdd/foster_e_hdd.bct BCT 2
	@mv $(dir $@)/ota.blob $@

include $(BUILD_SYSTEM)/base_rules.mk
ifeq ($(TARGET_PREBUILT_KERNEL),)
INSTALLED_RADIOIMAGE_TARGET += $(PRODUCT_OUT)/$(notdir $(_foster_e_hdd_blob))
endif

include $(CLEAR_VARS)
LOCAL_MODULE        := mdarcy.blob
LOCAL_MODULE_CLASS  := ETC
LOCAL_MODULE_PATH   := $(PRODUCT_OUT)

_mdarcy_blob_intermediates := $(call intermediates-dir-for,$(LOCAL_MODULE_CLASS),$(LOCAL_MODULE))
_mdarcy_blob := $(_mdarcy_blob_intermediates)/$(LOCAL_MODULE)$(LOCAL_MODULE_SUFFIX)

$(_mdarcy_blob):
	@mkdir -p $(dir $@)
	OUT=$(dir $@) TOP=$(BUILD_TOP) $(NVBLOB_HOST) -t update \
		$(FOSTER_BL)/mdarcy/rp4.blob RP4 2 \
		$(FOSTER_BL)/mdarcy/mdarcy_dtb.img RP1 2 \
		$(FOSTER_BL)/mdarcy/cboot.bin T210B01_EBT 2 \
		$(FOSTER_BL)/mdarcy/cboot.bin T210B01_RBL 2 \
		$(FOSTER_BL)/mdarcy/bpmp.bin T210B01_BPF 2 \
		$(FOSTER_BL)/mdarcy/nvtboot.bin T210B01_NVC 2 \
		$(FOSTER_BL)/mdarcy/nvtboot.bin T210B01_NVC-B 2 \
		$(FOSTER_BL)/mdarcy/nvtboot_cpu.bin T210B01_TBC 2 \
		$(FOSTER_BL)/mdarcy/nvtboot_cpu.bin T210B01_TBC-B 2 \
		$(FOSTER_BL)/mdarcy/warmboot.bin T210B01_WB0 2 \
		$(FOSTER_BL)/mdarcy/tos.img T210B01_TOS 2 \
		$(FOSTER_BL)/mdarcy/mdarcy.bct T210B01_BCT 2
	@mv $(dir $@)/ota.blob $@

include $(BUILD_SYSTEM)/base_rules.mk
INSTALLED_RADIOIMAGE_TARGET += $(PRODUCT_OUT)/$(notdir $(_mdarcy_blob))

include $(CLEAR_VARS)
LOCAL_MODULE        := sif.blob
LOCAL_MODULE_CLASS  := ETC
LOCAL_MODULE_PATH   := $(PRODUCT_OUT)

_sif_blob_intermediates := $(call intermediates-dir-for,$(LOCAL_MODULE_CLASS),$(LOCAL_MODULE))
_sif_blob := $(_sif_blob_intermediates)/$(LOCAL_MODULE)$(LOCAL_MODULE_SUFFIX)

$(_sif_blob):
	@mkdir -p $(dir $@)
	OUT=$(dir $@) TOP=$(BUILD_TOP) $(NVBLOB_HOST) -t update \
		$(FOSTER_BL)/sif/rp4.blob RP4 2 \
		$(FOSTER_BL)/sif/sif_dtb.img RP1 2 \
		$(FOSTER_BL)/sif/cboot.bin EBT 2 \
		$(FOSTER_BL)/sif/cboot.bin RBL 2 \
		$(FOSTER_BL)/sif/bpmp.bin BPF 2 \
		$(FOSTER_BL)/sif/nvtboot.bin NVC 2 \
		$(FOSTER_BL)/sif/nvtboot.bin NVC-B 2 \
		$(FOSTER_BL)/sif/nvtboot_cpu.bin TBC 2 \
		$(FOSTER_BL)/sif/nvtboot_cpu.bin TBC-B 2 \
		$(FOSTER_BL)/sif/warmboot.bin WB0 2 \
		$(FOSTER_BL)/sif/tos.img TOS 2 \
		$(FOSTER_BL)/sif/sif.bct BCT 2
	@mv $(dir $@)/ota.blob $@

include $(BUILD_SYSTEM)/base_rules.mk
INSTALLED_RADIOIMAGE_TARGET += $(PRODUCT_OUT)/$(notdir $(_sif_blob))

include $(CLEAR_VARS)
LOCAL_MODULE       := jetson_cv.blob
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH  := $(PRODUCT_OUT)

JETSON_CV_SIGNED_PATH := $(call intermediates-dir-for,$(LOCAL_MODULE_CLASS),$(LOCAL_MODULE))
_jetson_cv_br_bct     := $(JETSON_CV_SIGNED_PATH)/P2180_A00_LP4_DSC_204Mhz.bct
_jetson_cv_blob       := $(JETSON_CV_SIGNED_PATH)/$(LOCAL_MODULE)$(LOCAL_MODULE_SUFFIX)

$(_jetson_cv_br_bct): $(TOYBOX_HOST) $(INSTALLED_KERNEL_TARGET) $(INSTALLED_TOS_TARGET) | $(ACP)
	@mkdir -p $(dir $@)
	@cp $(FOSTER_FLASH)/flash_t210_android_sdmmc_fb.xml $(dir $@)/flash_t210_android_sdmmc_fb.xml.tmp
	@cp $(FOSTER_BCT)/P2180_A00_LP4_DSC_204Mhz.cfg $(dir $@)/
	@cp $(FOSTER_BL)/foster_e/*.bin $(dir $@)/
	@cp $(INSTALLED_TOS_TARGET) $(dir $@)/
	@cp $(KERNEL_OUT)/arch/arm64/boot/dts/$(DTB_SUBFOLDER)tegra210-jetson-tx1-p2597-2180-a01-android-devkit.dtb $(dir $@)/
	cd $(dir $@); $(TEGRAFLASH_PATH)/tegraparser --pt flash_t210_android_sdmmc_fb.xml.tmp
	cd $(dir $@); $(TEGRAFLASH_PATH)/tegrahost --chip 0x21 --partitionlayout flash_t210_android_sdmmc_fb.xml.bin --list images_list.xml
	cd $(dir $@); $(TEGRAFLASH_PATH)/tegrasign --key None --list images_list.xml --pubkeyhash pub_key.key
	cd $(dir $@); $(TEGRAFLASH_PATH)/tegrabct --bct P2180_A00_LP4_DSC_204Mhz.cfg --chip 0x21
	cd $(dir $@); $(TEGRAFLASH_PATH)/tegrabct --bct P2180_A00_LP4_DSC_204Mhz.bct --chip 0x21 --updatedevparam flash_t210_android_sdmmc_fb.xml.bin
	cd $(dir $@); $(TEGRAFLASH_PATH)/tegrabct --bct P2180_A00_LP4_DSC_204Mhz.bct --chip 0x21 --updateblinfo flash_t210_android_sdmmc_fb.xml.bin --updatesig images_list_signed.xml
	cd $(dir $@); $(TEGRAFLASH_PATH)/tegraparser --pt flash_t210_android_sdmmc_fb.xml.bin --chip 0x21 --updatecustinfo P2180_A00_LP4_DSC_204Mhz.bct
	cd $(dir $@); $(TEGRAFLASH_PATH)/tegraparser --chip 0x21 --updatecustinfo P2180_A00_LP4_DSC_204Mhz.bct
	cd $(dir $@); $(TEGRAFLASH_PATH)/tegrabct --bct P2180_A00_LP4_DSC_204Mhz.bct --chip 0x21 --updatefields "Odmdata =0x94000"
	cd $(dir $@); $(TEGRAFLASH_PATH)/tegrabct --bct P2180_A00_LP4_DSC_204Mhz.bct --chip 0x21 --listbct bct_list.xml
	cd $(dir $@); $(TEGRAFLASH_PATH)/tegrasign --key None --list bct_list.xml --pubkeyhash pub_key.key
	cd $(dir $@); $(TEGRAFLASH_PATH)/tegrabct --bct P2180_A00_LP4_DSC_204Mhz.bct --chip 0x21 --updatesig bct_list_signed.xml
	cd $(dir $@); $(TEGRAFLASH_PATH)/tegrahost --chip 0x21 --partitionlayout flash_t210_android_sdmmc_fb.xml.bin --updatesig images_list_signed.xml
	cd $(dir $@); $(TEGRAFLASH_PATH)/tegrabct --bct P2180_A00_LP4_DSC_204Mhz.bct --chip 0x21 --updatebfsinfo flash_t210_android_sdmmc_fb.xml.bin

$(_jetson_cv_blob): $(_jetson_cv_br_bct) $(INSTALLED_KERNEL_TARGET) | $(ACP)
	@mkdir -p $(dir $@)
	OUT=$(dir $@) TOP=$(BUILD_TOP) $(NVBLOB_HOST) -t update \
		$(FOSTER_BL)/foster_e/rp4.blob RP4 2 \
		$(KERNEL_OUT)/arch/arm64/boot/dts/$(DTB_SUBFOLDER)tegra210-jetson-tx1-p2597-2180-a01-android-devkit.dtb RP1 2 \
		$(JETSON_CV_SIGNED_PATH)/cboot.bin.encrypt EBT 2 \
		$(FOSTER_BL)/foster_e/bpmp_zeroes.bin BPF 2 \
		$(JETSON_CV_SIGNED_PATH)/nvtboot.bin.encrypt NVC 2 \
		$(JETSON_CV_SIGNED_PATH)/nvtboot_cpu.bin.encrypt TBC 2 \
		$(JETSON_CV_SIGNED_PATH)/warmboot.bin.encrypt WB0 2 \
		$(JETSON_CV_SIGNED_PATH)/tos-mon-only.img.encrypt TOS 2 \
		$(JETSON_CV_SIGNED_PATH)/P2180_A00_LP4_DSC_204Mhz.bct BCT 2
	@mv $(dir $@)/ota.blob $@

include $(BUILD_SYSTEM)/base_rules.mk

ifeq ($(TARGET_PREBUILT_KERNEL),)
INSTALLED_RADIOIMAGE_TARGET += $(PRODUCT_OUT)/$(notdir $(_jetson_cv_blob))
endif
