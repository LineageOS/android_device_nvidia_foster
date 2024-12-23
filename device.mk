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

TARGET_TEGRA_MODELS := $(shell awk -F, '/tegra_init::devices/{ f = 1; next } /};/{ f = 0 } f{ gsub(/"/, "", $$3); gsub(/ /, "", $$3); print $$3 }' device/nvidia/$(TARGET_REFERENCE_DEVICE)/init/init_$(TARGET_REFERENCE_DEVICE).cpp |sort |uniq)

TARGET_TEGRA_BT       ?= bcm
TARGET_TEGRA_CAMERA   ?= rel-shield-r
TARGET_TEGRA_KERNEL   ?= 4.9
TARGET_TEGRA_LIGHT    ?= lineage
TARGET_TEGRA_THERMAL  ?= lineage
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

PRODUCT_OTA_ENFORCE_VINTF_KERNEL_REQUIREMENTS := true

$(call inherit-product, frameworks/native/build/tablet-10in-xhdpi-2048-dalvik-heap.mk)

include device/nvidia/foster/vendor/foster-vendor.mk

# Overlays
DEVICE_PACKAGE_OVERLAYS += \
    device/nvidia/foster/overlay

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += device/nvidia/foster

# Init related
# Parameters
# $1 Variant name
# $2 Fstab source
# $3 Init rc name
# $4 Recovery rc name
# $5 Power rc name 
define initfiles_rule
device/nvidia/foster/initfiles/fstab.$(strip $(2)):$(TARGET_COPY_OUT_VENDOR)/etc/fstab.$(strip $(1)) \
device/nvidia/foster/initfiles/fstab.$(strip $(2)):$(TARGET_COPY_OUT_RAMDISK)/fstab.$(strip $(1)) \
device/nvidia/foster/initfiles/init.$(strip $(3)).rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.$(strip $(1)).rc \
device/nvidia/foster/initfiles/init.recovery.$(strip $(4)).rc:$(TARGET_COPY_OUT_RECOVERY)/root/init.recovery.$(strip $(1)).rc \
device/nvidia/foster/initfiles/power.$(strip $(5)).rc:$(TARGET_COPY_OUT_ODM)/etc/power.$(strip $(1)).rc
endef
PRODUCT_COPY_FILES += \
    $(call initfiles_rule, baracus,      emmc,   jetson_cv,    foster, foster_e_common ) \
    $(call initfiles_rule, batuu,        sd,     batuu,        foster, darcy           ) \
    $(call initfiles_rule, darcy,        emmc,   darcy,        darcy,  darcy           ) \
    $(call initfiles_rule, dragon,       dragon, dragon,       dragon, abca            ) \
    $(call initfiles_rule, foster_e,     emmc,   foster_e,     foster, foster_e_common ) \
    $(call initfiles_rule, foster_e_hdd, emmc,   foster_e_hdd, foster, foster_e_common ) \
    $(call initfiles_rule, jetson_cv,    emmc,   jetson_cv,    foster, foster_e_common ) \
    $(call initfiles_rule, jetson_e,     emmc,   jetson_e,     foster, foster_e_common ) \
    $(call initfiles_rule, loki_e_base,  emmc,   loki_e,       loki,   loki_e_common   ) \
    $(call initfiles_rule, loki_e_lte,   emmc,   loki_e,       loki,   loki_e_common   ) \
    $(call initfiles_rule, loki_e_wifi,  emmc,   loki_e,       loki,   loki_e_common   ) \
    $(call initfiles_rule, nx,           nx,     nx,           nx,     nx              ) \
    $(call initfiles_rule, porg,         emmc,   porg,         foster, darcy           ) \
    $(call initfiles_rule, porg_sd,      sd,     porg_sd,      foster, darcy           ) \
    $(call initfiles_rule, sif,          emmc,   sif,          sif,    darcy           ) \
    device/nvidia/foster/initfiles/init.foster_e_common.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.foster_e_common.rc \
    device/nvidia/foster/initfiles/init.loki_e_common.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.loki_e_common.rc \
    device/nvidia/foster/initfiles/init.loki_foster_e_common.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.loki_foster_e_common.rc \
    device/nvidia/foster/initfiles/init.recovery.foster_common.rc:$(TARGET_COPY_OUT_RECOVERY)/root/init.recovery.foster_common.rc

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
ifneq ($(filter rel-shield-r, $(TARGET_TEGRA_TOS)),)
PRODUCT_PACKAGES += \
    init.eks2.rc \
    eks2_darcy.dat \
    eks2_foster.dat \
    eks2_mdarcy.dat \
    eks2_public.dat \
    eks2_sif.dat
endif

# Fingerprint
PRODUCT_BUILD_PROP_OVERRIDES += \
    BuildFingerprint=NVIDIA/foster_e/foster:11/RQ1A.210105.003/7825230_3167.5736:user/release-keys

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

# Loadable kernel modules
PRODUCT_PACKAGES += \
    init.lkm.rc \
    lkm_loader \
    lkm_loader_target

# Media config
ifneq ($(filter-out software,$(TARGET_TEGRA_OMX)),)
PRODUCT_PACKAGES += \
    media_codecs.xml \
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
ifneq ($(TARGET_TEGRA_THERMAL),)
THERMAL_CONFIG_baracus      := darcy
THERMAL_CONFIG_batuu        := porg
THERMAL_CONFIG_darcy        := darcy
THERMAL_CONFIG_dragon       := darcy
THERMAL_CONFIG_foster_e     := darcy
THERMAL_CONFIG_foster_e_hdd := darcy
THERMAL_CONFIG_jetson_cv    := darcy
THERMAL_CONFIG_jetson_e     := darcy
THERMAL_CONFIG_loki_e_base  := loki_e
THERMAL_CONFIG_loki_e_lte   := loki_e
THERMAL_CONFIG_loki_e_wifi  := loki_e
THERMAL_CONFIG_nx           := darcy
THERMAL_CONFIG_porg         := porg
THERMAL_CONFIG_porg_sd      := porg
THERMAL_CONFIG_sif          := darcy
PRODUCT_COPY_FILES += \
    $(foreach model,$(TARGET_TEGRA_MODELS),device/nvidia/foster/thermal/thermalhal.$(THERMAL_CONFIG_$(model)).xml:$(TARGET_COPY_OUT_VENDOR)/etc/thermalhal.$(model).xml)
endif

# WiFi
ifeq ($(TARGET_TEGRA_WIFI),bcm)
PRODUCT_PACKAGES += \
    wifi_scan_config.conf
endif

PRODUCT_PACKAGES += \
    WifiOverlay
