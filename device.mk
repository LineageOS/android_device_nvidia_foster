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

TARGET_REFERENCE_DEVICE ?= foster
TARGET_TEGRA_VARIANT    ?= common

$(call inherit-product, device/nvidia/t210-common/t210.mk)

PRODUCT_CHARACTERISTICS  := tv
PRODUCT_AAPT_CONFIG      := xlarge large
PRODUCT_AAPT_PREF_CONFIG := xxhdpi
TARGET_SCREEN_HEIGHT     := 1920
TARGET_SCREEN_WIDTH      := 1080

$(call inherit-product, frameworks/native/build/tablet-10in-xhdpi-2048-dalvik-heap.mk)

# Init related
PRODUCT_PACKAGES += \
    fstab.darcy \
    fstab.dragon \
    fstab.foster \
    fstab.foster_e \
    fstab.foster_e_hdd \
    fstab.icosa \
    fstab.icosa_emmc \
    fstab.jetson_cv \
    fstab.jetson_e \
    fstab.loki_e_base \
    fstab.loki_e_lte \
    fstab.loki_e_wifi \
    fstab.porg \
    fstab.porg_sd \
    fstab.sif \
    init.darcy.rc \
    init.dragon.rc \
    init.foster_e.rc \
    init.foster_e_hdd.rc \
    init.foster_e_common.rc \
    init.loki_e_common.rc \
    init.loki_foster_e_common.rc \
    init.icosa.rc \
    init.icosa_common.rc \
    init.icosa_emmc.rc \
    init.jetson_cv.rc \
    init.jetson_e.rc \
    init.loki_e_base.rc \
    init.loki_e_lte.rc \
    init.loki_e_wifi.rc \
    init.porg.rc \
    init.porg_sd.rc \
    init.sif.rc \
    init.recovery.darcy.rc \
    init.recovery.dragon.rc \
    init.recovery.foster_e.rc \
    init.recovery.foster_e_hdd.rc \
    init.recovery.foster_common.rc \
    init.recovery.icosa.rc \
    init.recovery.icosa_emmc.rc \
    init.recovery.jetson_cv.rc \
    init.recovery.jetson_e.rc \
    init.recovery.loki_e_base.rc \
    init.recovery.loki_e_lte.rc \
    init.recovery.loki_e_wifi.rc \
    init.recovery.porg.rc \
    init.recovery.porg_sd.rc \
    init.recovery.sif.rc \
    power.darcy.rc \
    power.dragon.rc \
    power.foster_e.rc \
    power.foster_e_hdd.rc \
    power.icosa.rc \
    power.icosa_emmc.rc \
    power.jetson_cv.rc \
    power.jetson_e.rc \
    power.loki_e_base.rc \
    power.loki_e_lte.rc \
    power.loki_e_wifi.rc \
    power.porg.rc \
    power.porg_sd.rc \
    power.sif.rc

# Kernel
ifneq ($(TARGET_PREBUILT_KERNEL),)
PRODUCT_COPY_FILES += \
    $(TARGET_PREBUILT_KERNEL):kernel
endif
