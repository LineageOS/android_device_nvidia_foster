# Copyright (C) 2020 The LineageOS Project
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

ifeq ($(TARGET_PREBUILT_KERNEL),)
INSTALLED_KERNEL_TARGET := $(PRODUCT_OUT)/kernel

ifneq ($(filter 3.10 4.9, $(TARGET_TEGRA_KERNEL)),)
DTB_PATH := $(abspath $(KERNEL_OUT)/arch/arm64/boot/dts)
else ifneq ($(findstring dtstree,$(TARGET_KERNEL_ADDITIONAL_FLAGS)),)
DTB_PATH := $(abspath $(KERNEL_OUT)/../nv-oot/device-tree/platform/generic-dts/t21x/lineage)
else
DTB_PATH := $(abspath $(KERNEL_OUT)/arch/arm64/boot/dts/nvidia)
endif

DTB_TARGETS := \
    tegra210-darcy-p2894-0000-a00-00.dtb \
    tegra210-darcy-p2894-0050-a04-00.dtb \
    tegra210-darcy-p2894-0050-a08-00.dtb \
    tegra210-darcy-p2894-0052-a08-00.dtb \
    tegra210-foster-e-hdd-p2530-0932-e01-00.dtb \
    tegra210-foster-e-hdd-p2530-0932-e02-00.dtb \
    tegra210-foster-e-p2530-0930-e01-00.dtb \
    tegra210-foster-e-p2530-0930-e02-00.dtb \
    tegra210-jetson-tx1-p2597-2180-a01-android-devkit.dtb \
    tegra210-loki-e-p2530-0030-e01-00.dtb \
    tegra210-loki-e-p2530-0030-e02-00.dtb \
    tegra210-loki-e-p2530-0030-e03-00.dtb \
    tegra210-loki-e-p2530-0031-e01-00.dtb \
    tegra210-loki-e-p2530-0031-e02-00.dtb \
    tegra210-loki-e-p2530-0031-e03-00.dtb
INSTALLED_DTB_TARGETS := $(DTB_TARGETS:%=$(PRODUCT_OUT)/install/%)
$(INSTALLED_DTB_TARGETS): $(INSTALLED_KERNEL_TARGET) | $(ACP)
	echo -e ${CL_GRN}"Copying individual DTBs"${CL_RST}
	@mkdir -p $(PRODUCT_OUT)/install
	cp $(@F:%=$(DTB_PATH)/%) $(PRODUCT_OUT)/install/

ALL_DEFAULT_INSTALLED_MODULES += $(INSTALLED_DTB_TARGETS)

INSTALLED_DTBIMAGE_TARGET_mdarcy := $(PRODUCT_OUT)/install/mdarcy.dtb.img
$(INSTALLED_DTBIMAGE_TARGET_mdarcy): $(INSTALLED_KERNEL_TARGET) | mkdtimg
	echo -e ${CL_GRN}"Building mdarcy DTImage"${CL_RST}
	@mkdir -p $(PRODUCT_OUT)/install
	$(HOST_OUT_EXECUTABLES)/mkdtimg create $@ --id=2894 \
		$(DTB_PATH)/tegra210b01-darcy-p2894-0050-a08-00.dtb --rev=0x0a8 --custom0=0x28 \
		$(DTB_PATH)/tegra210b01-darcy-p2894-2551-b00-00.dtb --rev=0xb00 --custom0=2551 \
		$(DTB_PATH)/tegra210b01-darcy-p2894-3551-b03-00.dtb --rev=0xb03 --custom0=3551

INSTALLED_DTBIMAGE_TARGET_sif    := $(PRODUCT_OUT)/install/sif.dtb.img
$(INSTALLED_DTBIMAGE_TARGET_sif): $(INSTALLED_KERNEL_TARGET) | mkdtimg
	echo -e ${CL_GRN}"Building sif DTImage"${CL_RST}
	@mkdir -p $(PRODUCT_OUT)/install
	$(HOST_OUT_EXECUTABLES)/mkdtimg create $@ --id=3425 --custom0=0x140 \
		$(DTB_PATH)/tegra210b01-sif-p3425-0500-a01.dtb --rev=0xa1 \
		$(DTB_PATH)/tegra210b01-sif-p3425-0500-a02.dtb --rev=0xa2 \
		$(DTB_PATH)/tegra210b01-sif-p3425-0500-a04.dtb --rev=0xa3 \
		$(DTB_PATH)/tegra210b01-sif-p3425-0500-a04.dtb --rev=0xa4

ALL_DEFAULT_INSTALLED_MODULES += $(INSTALLED_DTBIMAGE_TARGET_mdarcy) $(INSTALLED_DTBIMAGE_TARGET_sif)

ifneq ("$(wildcard hardware/nvidia/platform/t210/nx)","")
INSTALLED_DTBIMAGE_TARGET_nx     := $(PRODUCT_OUT)/install/nx.dtb.img
$(INSTALLED_DTBIMAGE_TARGET_nx): $(INSTALLED_KERNEL_TARGET) | mkdtimg
	echo -e ${CL_GRN}"Building nx DTImage"${CL_RST}
	@mkdir -p $(PRODUCT_OUT)/install
	$(HOST_OUT_EXECUTABLES)/mkdtimg create $@ \
		$(DTB_PATH)/tegra210-odin.dtb    --id=0x4F44494E --rev=0xa00 \
		$(DTB_PATH)/tegra210b01-odin.dtb --id=0x4F44494E --rev=0xb01 \
		$(DTB_PATH)/tegra210b01-vali.dtb --id=0x56414C49 --rev=0xa00 \
		$(DTB_PATH)/tegra210b01-frig.dtb --id=0x46524947 --rev=0xa00

ALL_DEFAULT_INSTALLED_MODULES += $(INSTALLED_DTBIMAGE_TARGET_nx)
endif
endif

AVBTOOL_HOST := $(HOST_OUT_EXECUTABLES)/avbtool
INSTALLED_VBMETA_SKIP_TARGET := $(PRODUCT_OUT)/install/vbmeta_skip.img
$(INSTALLED_VBMETA_SKIP_TARGET): $(AVBTOOL_HOST)
	@$(AVBTOOL_HOST) make_vbmeta_image --flags 2 --padding_size 256 --output $@

ALL_DEFAULT_INSTALLED_MODULES += $(INSTALLED_VBMETA_SKIP_TARGET)

ifeq ($(word 2,$(subst _, ,$(TARGET_PRODUCT))),foster)
BUILT_TARGET_FILES_ZIPROOT := $(call intermediates-dir-for,PACKAGING,target_files)/$(TARGET_PRODUCT)-target_files
$(BUILT_TARGET_FILES_ZIPROOT).zip: $(BUILT_TARGET_FILES_ZIPROOT)/IMAGES/p2371_flash_package.txz

$(BUILT_TARGET_FILES_ZIPROOT)/IMAGES/p2371_flash_package.txz: $(BUILT_TARGET_FILES_ZIPROOT).zip.list $(PRODUCT_OUT)/p2371_flash_package.txz
	@mkdir -p $(dir $@)
	@cp $(PRODUCT_OUT)/p2371_flash_package.txz $@
	@echo $@ >> $(BUILT_TARGET_FILES_ZIPROOT).zip.list
endif
