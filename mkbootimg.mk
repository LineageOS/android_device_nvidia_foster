#
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
#

LOCAL_PATH := $(call my-dir)

# Mdarcy and Sif require a dtimage in the recovery dtbo slot
# On other platforms, this dtimage is completely ignored by cboot
# So only dt's related to mdarcy and sif should be part of this list
INSTALLED_DTBIMAGE_TARGET_mdarcy_recovery := $(PRODUCT_OUT)/mdarcy_recovery.dtb.img
ifeq ($(TARGET_PREBUILT_KERNEL),)
ifneq ($(filter 3.10 4.9, $(TARGET_TEGRA_KERNEL)),)
DTB_PATH := $(abspath $(KERNEL_OUT)/arch/arm64/boot/dts)
else ifneq ($(findstring dtstree,$(TARGET_KERNEL_ADDITIONAL_FLAGS)),)
DTB_PATH := $(abspath $(KERNEL_OUT)/../nv-oot/device-tree/platform/generic-dts/t21x/lineage)
else
DTB_PATH := $(abspath $(KERNEL_OUT)/arch/arm64/boot/dts/nvidia)
endif


$(INSTALLED_DTBIMAGE_TARGET_mdarcy_recovery): $(INSTALLED_KERNEL_TARGET) | mkdtimg
	echo -e ${CL_GRN}"Building mdarcy recovery DTImage"${CL_RST}
	$(HOST_OUT_EXECUTABLES)/mkdtimg create $@ \
		$(DTB_PATH)/tegra210b01-darcy-p2894-0050-a08-00.dtb --id=2894 --rev=0x0a8 --custom0=0x28  \
		$(DTB_PATH)/tegra210b01-darcy-p2894-2551-b00-00.dtb --id=2894 --rev=0xb00 --custom0=2551  \
		$(DTB_PATH)/tegra210b01-darcy-p2894-3551-b03-00.dtb --id=2894 --rev=0xb03 --custom0=3551  \
		$(DTB_PATH)/tegra210b01-sif-p3425-0500-a01.dtb      --id=3425 --rev=0xa1  --custom0=0x140 \
		$(DTB_PATH)/tegra210b01-sif-p3425-0500-a02.dtb      --id=3425 --rev=0xa2  --custom0=0x140 \
		$(DTB_PATH)/tegra210b01-sif-p3425-0500-a04.dtb      --id=3425 --rev=0xa3  --custom0=0x140 \
		$(DTB_PATH)/tegra210b01-sif-p3425-0500-a04.dtb      --id=3425 --rev=0xa4  --custom0=0x140
else
$(INSTALLED_DTBIMAGE_TARGET_mdarcy_recovery): | mkdtimg
	echo -e ${CL_GRN}"Building mdarcy recovery DTImage"${CL_RST}
	$(HOST_OUT_EXECUTABLES)/mkdtimg dump $(dir $(TARGET_PREBUILT_KERNEL))/mdarcy.dtb.img \
		-b $(PRODUCT_OUT)/mdarcy.dtb
	$(HOST_OUT_EXECUTABLES)/mkdtimg dump $(dir $(TARGET_PREBUILT_KERNEL))/sif.dtb.img \
		-b $(PRODUCT_OUT)/sif.dtb
	$(HOST_OUT_EXECUTABLES)/mkdtimg create $@ \
		$(PRODUCT_OUT)/mdarcy.dtb.0 --id=2894 --rev=0x0a8 --custom0=0x28  \
		$(PRODUCT_OUT)/mdarcy.dtb.1 --id=2894 --rev=0xb00 --custom0=2551  \
		$(PRODUCT_OUT)/mdarcy.dtb.2 --id=2894 --rev=0xb03 --custom0=3551  \
		$(PRODUCT_OUT)/sif.dtb.0    --id=3425 --rev=0xa1  --custom0=0x140 \
	        $(PRODUCT_OUT)/sif.dtb.1    --id=3425 --rev=0xa2  --custom0=0x140 \
		$(PRODUCT_OUT)/sif.dtb.2    --id=3425 --rev=0xa3  --custom0=0x140 \
		$(PRODUCT_OUT)/sif.dtb.3    --id=3425 --rev=0xa4  --custom0=0x140
endif

# Normal bootimg to nest
$(PRODUCT_OUT)/boot-nest.img: $(MKBOOTIMG) $(INTERNAL_BOOTIMAGE_FILES) $(BOOTIMAGE_EXTRA_DEPS) $(INSTALLED_KERNEL_TARGET)
	$(call pretty,"Target boot image: $@")
	$(hide) $(MKBOOTIMG) --kernel $(call bootimage-to-kernel,$@) $(INTERNAL_BOOTIMAGE_ARGS) $(INTERNAL_MKBOOTIMG_VERSION_ARGS) $(BOARD_MKBOOTIMG_ARGS) --output $@

# wrapper bootimg
$(INSTALLED_BOOTIMAGE_TARGET): $(PRODUCT_OUT)/boot-nest.img
	$(call pretty,"Nested boot image: $@")
	$(MKBOOTIMG) --kernel $(PRODUCT_OUT)/u-boot.bin --ramdisk $(PRODUCT_OUT)/boot-nest.img $(INTERNAL_MKBOOTIMG_VERSION_ARGS) --output $@
	$(hide )$(call assert-max-image-size,$@,$(call get-bootimage-partition-size,$@,boot))

INTERNAL_RECOVERYIMAGE_ARGS += --recovery_dtbo $(INSTALLED_DTBIMAGE_TARGET_mdarcy_recovery)
$(INSTALLED_RECOVERYIMAGE_TARGET): $(recoveryimage-deps) $(RECOVERYIMAGE_EXTRA_DEPS) $(INSTALLED_DTBIMAGE_TARGET_mdarcy_recovery)
	$(call build-recoveryimage-target, $@, $(recovery_kernel))
