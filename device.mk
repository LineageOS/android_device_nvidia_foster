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

# Only include Shield apps for first party targets
ifneq ($(filter $(word 2,$(subst _, ,$(TARGET_PRODUCT))), foster foster_tab),)
$(call inherit-product, device/nvidia/shield-common/shield.mk)
endif

TARGET_REFERENCE_DEVICE ?= foster
TARGET_TEGRA_VARIANT    ?= common

TARGET_TEGRA_AUDIO    ?= nvaudio
TARGET_TEGRA_BT       ?= bcm
TARGET_TEGRA_CEC      ?= nvhdmi
TARGET_TEGRA_OMX      ?= nvmm
TARGET_TEGRA_WIFI     ?= bcm

$(call inherit-product, device/nvidia/t210-common/t210.mk)
$(call inherit-product, device/nvidia/touch/raydium.mk)

# System properties
include $(LOCAL_PATH)/system_prop.mk

PRODUCT_CHARACTERISTICS  := tv
PRODUCT_AAPT_CONFIG      := xlarge large
PRODUCT_AAPT_PREF_CONFIG := xxhdpi
TARGET_SCREEN_HEIGHT     := 1920
TARGET_SCREEN_WIDTH      := 1080

$(call inherit-product, frameworks/native/build/tablet-10in-xhdpi-2048-dalvik-heap.mk)

$(call inherit-product, vendor/nvidia/foster/foster-vendor.mk)

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

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.audio.low_latency.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.audio.low_latency.xml \
    frameworks/native/data/etc/android.hardware.ethernet.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.ethernet.xml

# ATV specific stuff
ifeq ($(PRODUCT_IS_ATV),true)
    PRODUCT_PACKAGES += \
        android.hardware.tv.input@1.0-impl
endif

# Audio
ifeq ($(TARGET_TEGRA_AUDIO),nvaudio)
PRODUCT_PACKAGES += \
    audio_effects.xml \
    audio_policy_configuration.xml \
    dragon_nvaudio_conf.xml \
    icosa_nvaudio_conf.xml \
    icosa_emmc_nvaudio_conf.xml \
    nvaudio_conf.xml \
    nvaudio_fx.xml
endif

# Charger
PRODUCT_PACKAGES += \
    charger \
    charger_res_images

# Joycon daemon
PRODUCT_PACKAGES += \
	joycond

# Kernel
ifneq ($(TARGET_PREBUILT_KERNEL),)
PRODUCT_COPY_FILES += \
    $(TARGET_PREBUILT_KERNEL):kernel
else
PRODUCT_PACKAGES += \
    cypress-fmac
endif

# Loadable kernel modules
PRODUCT_PACKAGES += \
    init.lkm.rc \
    lkm_loader

# Media config
PRODUCT_COPY_FILES += \
    frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:$(TARGET_COPY_OUT_ODM)/etc/media_codecs_google_audio.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_video.xml:$(TARGET_COPY_OUT_ODM)/etc/media_codecs_google_video.xml
PRODUCT_PACKAGES += \
    media_codecs.xml
ifeq ($(TARGET_TEGRA_OMX),nvmm)
PRODUCT_PACKAGES += \
    media_codecs_performance.xml \
    media_profiles_V1_0.xml
endif

# Netflix nrdp
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/permissions/nrdp.modelgroup.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/nrdp.modelgroup.xml

# NVIDIA specific permissions
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/permissions/com.nvidia.feature.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/com.nvidia.feature.xml

# Thermal
PRODUCT_PACKAGES += \
    android.hardware.thermal@1.0-service-nvidia \
    thermalhal.darcy.xml \
    thermalhal.jetson_cv.xml \
    thermalhal.jetson_e.xml \
    thermalhal.loki_e_lte.xml \
    thermalhal.loki_e_wifi.xml \
    thermalhal.sif.xml

# WiFi
ifeq ($(TARGET_TEGRA_WIFI),bcm)
PRODUCT_PACKAGES += \
    wifi_scan_config.conf
endif
