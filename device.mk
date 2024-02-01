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
include device/nvidia/shield-common/shield.mk
endif

TARGET_REFERENCE_DEVICE ?= foster
TARGET_TEGRA_VARIANT    ?= common

TARGET_TEGRA_BT       ?= bcm
TARGET_TEGRA_CAMERA   ?= rel-shield-r
TARGET_TEGRA_KERNEL   ?= 4.9
TARGET_TEGRA_WIDEVINE ?= rel-shield-r
TARGET_TEGRA_WIFI     ?= bcm

ifneq ($(filter 3.10 4.9, $(TARGET_TEGRA_KERNEL)),)
TARGET_TEGRA_WIREGUARD ?= compat
endif

include device/nvidia/t210-common/t210.mk

# Properties
include device/nvidia/foster/properties.mk

PRODUCT_CHARACTERISTICS   := tv
PRODUCT_AAPT_PREBUILT_DPI := xxhdpi xhdpi hdpi mdpi hdpi tvdpi
PRODUCT_AAPT_PREF_CONFIG  := xhdpi

$(call inherit-product, frameworks/native/build/tablet-10in-xhdpi-2048-dalvik-heap.mk)

include device/nvidia/foster/vendor/foster-vendor.mk

# Overlays
DEVICE_PACKAGE_OVERLAYS += \
    device/nvidia/foster/overlay

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += device/nvidia/foster

# Init related
PRODUCT_PACKAGES += \
    fstab.batuu \
    fstab.darcy \
    fstab.dragon \
    fstab.foster \
    fstab.foster_e \
    fstab.foster_e_hdd \
    fstab.jetson_cv \
    fstab.jetson_e \
    fstab.loki_e_base \
    fstab.loki_e_lte \
    fstab.loki_e_wifi \
    fstab.nx \
    fstab.porg \
    fstab.porg_sd \
    fstab.sif \
    init.batuu.rc \
    init.darcy.rc \
    init.dragon.rc \
    init.foster_e.rc \
    init.foster_e_hdd.rc \
    init.foster_e_common.rc \
    init.loki_e_common.rc \
    init.loki_foster_e_common.rc \
    init.jetson_cv.rc \
    init.jetson_e.rc \
    init.loki_e_base.rc \
    init.loki_e_lte.rc \
    init.loki_e_wifi.rc \
    init.nx.rc \
    init.porg.rc \
    init.porg_sd.rc \
    init.sif.rc \
    init.recovery.batuu.rc \
    init.recovery.darcy.rc \
    init.recovery.dragon.rc \
    init.recovery.foster_e.rc \
    init.recovery.foster_e_hdd.rc \
    init.recovery.foster_common.rc \
    init.recovery.jetson_cv.rc \
    init.recovery.jetson_e.rc \
    init.recovery.loki_e_base.rc \
    init.recovery.loki_e_lte.rc \
    init.recovery.loki_e_wifi.rc \
    init.recovery.nx.rc \
    init.recovery.porg.rc \
    init.recovery.porg_sd.rc \
    init.recovery.sif.rc \
    power.batuu.rc \
    power.darcy.rc \
    power.dragon.rc \
    power.foster_e.rc \
    power.foster_e_hdd.rc \
    power.jetson_cv.rc \
    power.jetson_e.rc \
    power.loki_e_base.rc \
    power.loki_e_lte.rc \
    power.loki_e_wifi.rc \
    power.nx.rc \
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
ifneq ($(TARGET_TEGRA_AUDIO),)
PRODUCT_PACKAGES += \
    audio_effects.xml \
    audio_policy_configuration.xml \

ifeq ($(TARGET_TEGRA_AUDIO),tinyhal)
PRODUCT_PACKAGES += \
    audio.darcy.xml \
    audio.foster.xml \
    audio.jetson.xml \
    audio.mdarcy.xml \
    audio.porg.xml \
    audio.sif.xml
else ifneq ($(filter rel-shield-r, $(TARGET_TEGRA_AUDIO)),)
PRODUCT_PACKAGES += \
    audio_policy_configuration_dragon.xml \
    audio_policy_configuration_loki.xml \
    audio_policy_configuration_nx.xml \
    dragon_nvaudio_conf.xml \
    loki_e_base_nvaudio_conf.xml \
    loki_e_lte_nvaudio_conf.xml \
    loki_e_wifi_nvaudio_conf.xml \
    nx_nvaudio_conf.xml \
    nvaudio_conf.xml \
    nvaudio_fx.xml
endif
endif

# EKS
ifneq ($(filter rel-shield-r, $(TARGET_TEGRA_KEYSTORE)),)
PRODUCT_PACKAGES += \
    init.eks2.rc \
    eks2_darcy.dat \
    eks2_foster.dat \
    eks2_mdarcy.dat \
    eks2_public.dat \
    eks2_sif.dat
endif

# Kernel
ifneq ($(TARGET_PREBUILT_KERNEL),)
TARGET_FORCE_PREBUILT_KERNEL := true
else ifeq ($(TARGET_TEGRA_KERNEL),4.9)
PRODUCT_PACKAGES += \
    cypress-fmac
endif

# Keylayouts
PRODUCT_PACKAGES += \
    gpio-keys.kl \
    gpio-keys-loki.kl

# Light
PRODUCT_PACKAGES += \
    android.hardware.light@2.0-service-nvidia

# Loadable kernel modules
PRODUCT_PACKAGES += \
    init.lkm.rc \
    lkm_loader \
    lkm_loader_target

# Media config
PRODUCT_COPY_FILES += \
    frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:$(TARGET_COPY_OUT_ODM)/etc/media_codecs_google_audio.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_video.xml:$(TARGET_COPY_OUT_ODM)/etc/media_codecs_google_video.xml
PRODUCT_PACKAGES += \
    media_codecs.xml
ifneq ($(filter-out software,$(TARGET_TEGRA_OMX)),)
PRODUCT_PACKAGES += \
    media_codecs_performance.xml \
    media_profiles_V1_0.xml \
    enctune.conf
endif

# Netflix
ifeq ($(PRODUCT_IS_ATV),true)
PRODUCT_PACKAGES += \
    NetflixConfig \
    NetflixConfigOverlay
PRODUCT_COPY_FILES += \
    device/nvidia/foster/permissions/netflix.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/netflix.xml \
    device/nvidia/foster/permissions/nrdp.modelgroup.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/nrdp.modelgroup.xml
endif

# NVIDIA specific permissions
PRODUCT_COPY_FILES += \
    device/nvidia/foster/permissions/com.nvidia.feature.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/com.nvidia.feature.xml

# PHS
ifneq ($(TARGET_TEGRA_PHS),)
PRODUCT_PACKAGES += \
    nvphsd.conf
endif

# Power
PRODUCT_COPY_FILES += \
    system/core/libprocessgroup/profiles/cgroups_28.json:$(TARGET_COPY_OUT_VENDOR)/etc/cgroups.json \
    system/core/libprocessgroup/profiles/task_profiles_28.json:$(TARGET_COPY_OUT_VENDOR)/etc/task_profiles.json

# SKU Specific Overlays
PRODUCT_PACKAGES += \
    DarcyOverlay

# Thermal
PRODUCT_PACKAGES += \
    android.hardware.thermal@1.0-service-nvidia \
    thermalhal.batuu.xml \
    thermalhal.darcy.xml \
    thermalhal.foster_e.xml \
    thermalhal.foster_e_hdd.xml \
    thermalhal.nx.xml \
    thermalhal.jetson_cv.xml \
    thermalhal.jetson_e.xml \
    thermalhal.loki_e_lte.xml \
    thermalhal.loki_e_wifi.xml \
    thermalhal.porg.xml \
    thermalhal.porg_sd.xml \
    thermalhal.sif.xml

# Treble workaround
PRODUCT_PACKAGES += $(PRODUCT_PACKAGES_SHIPPING_API_LEVEL_29)

# Trust HAL
PRODUCT_PACKAGES += \
    vendor.lineage.trust@1.0-service

# WiFi
ifeq ($(TARGET_TEGRA_WIFI),bcm)
PRODUCT_PACKAGES += \
    wifi_scan_config.conf
endif

PRODUCT_PACKAGES += \
    WifiOverlay
