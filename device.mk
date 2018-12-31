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

TARGET_TEGRA_AUDIO    ?= nvaudio
TARGET_TEGRA_OMX      ?= nvmm

$(call inherit-product, device/nvidia/t210-common/t210.mk)

PRODUCT_CHARACTERISTICS  ?= tv
PRODUCT_AAPT_CONFIG      := xlarge large
PRODUCT_AAPT_PREF_CONFIG := xxhdpi
TARGET_SCREEN_HEIGHT     := 1920
TARGET_SCREEN_WIDTH      := 1080

$(call inherit-product, frameworks/native/build/tablet-10in-xhdpi-2048-dalvik-heap.mk)

$(call inherit-product, vendor/nvidia/foster/foster-vendor.mk)

# Init related
PRODUCT_PACKAGES += \
    fstab.darcy \
    fstab.foster \
    fstab.foster_e \
    fstab.foster_e_hdd \
    fstab.jetson_cv \
    fstab.jetson_e \
    fstab.loki_e_base \
    fstab.loki_e_lte \
    fstab.loki_e_wifi \
    fstab.porg \
    fstab.sif \
    init.darcy.rc \
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
    init.porg.rc \
    init.sif.rc \
    init.recovery.darcy.rc \
    init.recovery.foster_e.rc \
    init.recovery.foster_e_hdd.rc \
    init.recovery.jetson_cv.rc \
    init.recovery.jetson_e.rc \
    init.recovery.loki_e_base.rc \
    init.recovery.loki_e_lte.rc \
    init.recovery.loki_e_wifi.rc \
    init.recovery.porg.rc \
    init.recovery.sif.rc \
    power.darcy.rc \
    power.foster_e.rc \
    power.foster_e_hdd.rc \
    power.jetson_cv.rc \
    power.jetson_e.rc \
    power.loki_e_base.rc \
    power.loki_e_lte.rc \
    power.loki_e_wifi.rc \
    power.porg.rc \
    power.sif.rc

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.audio.low_latency.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.audio.low_latency.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.location.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.location.xml

# Audio
ifeq ($(TARGET_TEGRA_AUDIO),nvaudio)
PRODUCT_PACKAGES += \
    audio_effects.conf \
    audio_policy.conf \
    nvaudio_conf.xml \
    nvaudio_fx.xml
endif

# Camera
PRODUCT_PACKAGES += \
    camera.device@3.2-impl \
    android.hardware.camera.provider@2.4-impl

# Fingerprint override
BUILD_FINGERPRINT := NVIDIA/foster_e/foster:8.0.0/OPR6.170623.010/3507953_1441.7411:user/release-keys

# GPS
PRODUCT_PACKAGES += \
    android.hardware.gnss@1.0-impl \
    gps.conf \
    gpsconfig.xml

# Media config
PRODUCT_COPY_FILES += \
    frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_audio.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_video.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_video.xml
ifeq ($(TARGET_TEGRA_OMX),nvmm)
PRODUCT_PACKAGES += \
    media_codecs.xml \
    media_codecs_performance.xml \
    media_profiles.xml
else
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/media/media_codecs_sw.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs.xml
endif
