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

ifeq ($(filter 3.10 4.9, $(TARGET_TEGRA_KERNEL)),)
DTB_SUBFOLDER := nvidia/
endif

DTB_TARGETS := tegra210-darcy-p2894-0000-a00-00.dtb \
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
               tegra210-loki-e-p2530-0031-e03-00.dtb \
               tegra210-loki-e-p2530-0030-e01-00-rel24.dtb \
               tegra210-loki-e-p2530-0030-e02-00-rel24.dtb \
               tegra210-loki-e-p2530-0030-e03-00-rel24.dtb \
               tegra210-loki-e-p2530-0031-e01-00-rel24.dtb \
               tegra210-loki-e-p2530-0031-e02-00-rel24.dtb \
               tegra210-loki-e-p2530-0031-e03-00-rel24.dtb
INSTALLED_DTB_TARGETS := $(DTB_TARGETS:%=$(PRODUCT_OUT)/install/%)
$(INSTALLED_DTB_TARGETS): $(INSTALLED_KERNEL_TARGET) | $(ACP)
	echo -e ${CL_GRN}"Copying individual DTBs"${CL_RST}
	@mkdir -p $(PRODUCT_OUT)/install
	cp $(@F:%=$(KERNEL_OUT)/arch/arm64/boot/dts/$(DTB_SUBFOLDER)%) $(PRODUCT_OUT)/install/

ALL_DEFAULT_INSTALLED_MODULES += $(INSTALLED_DTB_TARGETS)

INSTALLED_DTBIMAGE_TARGET_mdarcy := $(PRODUCT_OUT)/install/mdarcy.dtb.img
$(INSTALLED_DTBIMAGE_TARGET_mdarcy): $(INSTALLED_KERNEL_TARGET) | mkdtimg
	echo -e ${CL_GRN}"Building mdarcy DTImage"${CL_RST}
	@mkdir -p $(PRODUCT_OUT)/install
	$(HOST_OUT_EXECUTABLES)/mkdtimg create $@ --id=2894 \
		$(KERNEL_OUT)/arch/arm64/boot/dts/$(DTB_SUBFOLDER)tegra210b01-darcy-p2894-0050-a08-00.dtb --rev=0x0a8 --custom0=0x28 \
		$(KERNEL_OUT)/arch/arm64/boot/dts/$(DTB_SUBFOLDER)tegra210b01-darcy-p2894-2551-b00-00.dtb --rev=0xb00 --custom0=2551 \
		$(KERNEL_OUT)/arch/arm64/boot/dts/$(DTB_SUBFOLDER)tegra210b01-darcy-p2894-3551-b03-00.dtb --rev=0xb03 --custom0=3551

INSTALLED_DTBIMAGE_TARGET_sif    := $(PRODUCT_OUT)/install/sif.dtb.img
$(INSTALLED_DTBIMAGE_TARGET_sif): $(INSTALLED_KERNEL_TARGET) | mkdtimg
	echo -e ${CL_GRN}"Building sif DTImage"${CL_RST}
	@mkdir -p $(PRODUCT_OUT)/install
	$(HOST_OUT_EXECUTABLES)/mkdtimg create $@ --id=3425 --custom0=0x140 \
		$(KERNEL_OUT)/arch/arm64/boot/dts/$(DTB_SUBFOLDER)tegra210b01-sif-p3425-0500-a01.dtb --rev=0xa1 \
		$(KERNEL_OUT)/arch/arm64/boot/dts/$(DTB_SUBFOLDER)tegra210b01-sif-p3425-0500-a02.dtb --rev=0xa2 \
		$(KERNEL_OUT)/arch/arm64/boot/dts/$(DTB_SUBFOLDER)tegra210b01-sif-p3425-0500-a04.dtb --rev=0xa3 \
		$(KERNEL_OUT)/arch/arm64/boot/dts/$(DTB_SUBFOLDER)tegra210b01-sif-p3425-0500-a04.dtb --rev=0xa4

ALL_DEFAULT_INSTALLED_MODULES += $(INSTALLED_DTBIMAGE_TARGET_mdarcy) $(INSTALLED_DTBIMAGE_TARGET_sif)
endif

EKS_DAT_SYMLINK := $(TARGET_OUT_VENDOR)/app/eks2/eks2.dat
$(EKS_DAT_SYMLINK): $(LOCAL_INSTALLED_MODULE)
	$(hide) ln -sf /data/vendor/eks2/eks2.dat $@

ALL_DEFAULT_INSTALLED_MODULES += $(EKS_DAT_SYMLINK)

AVBTOOL_HOST := $(HOST_OUT_EXECUTABLES)/avbtool
INSTALLED_VBMETA_SKIP_TARGET := $(PRODUCT_OUT)/install/vbmeta_skip.img
$(INSTALLED_VBMETA_SKIP_TARGET): $(AVBTOOL_HOST)
	@$(AVBTOOL_HOST) make_vbmeta_image --flags 2 --padding_size 256 --output $@

ALL_DEFAULT_INSTALLED_MODULES += $(INSTALLED_VBMETA_SKIP_TARGET)
