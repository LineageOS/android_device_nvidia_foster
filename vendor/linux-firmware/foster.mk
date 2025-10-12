# Copyright (C) 2024 The LineageOS Project
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

LOCAL_PATH := device/nvidia/foster/vendor/linux-firmware
PRODUCT_SOONG_NAMESPACES += $(LOCAL_PATH)

FOSTER_COMMS_BRANCH := rel-shield-r
FOSTER_BCM_PATH := vendor/nvidia/foster/$(FOSTER_COMMS_BRANCH)/bcm
REL30_BCM_PATH := vendor/nvidia/foster/rel-30/bcm
EXTERNAL_BCM_PATH := vendor/nvidia/common/external/bcm

include device/nvidia/tegra-common/vendor/$(TARGET_TEGRA_FIRMWARE_BRANCH)/bcm/bcm4354.mk
include device/nvidia/tegra-common/vendor/$(TARGET_TEGRA_FIRMWARE_BRANCH)/bcm/bcm4356.mk
include device/nvidia/tegra-common/vendor/$(TARGET_TEGRA_FIRMWARE_BRANCH)/realtek/rtl8152.mk
include device/nvidia/tegra-common/vendor/$(TARGET_TEGRA_FIRMWARE_BRANCH)/realtek/rtl8168.mk

# Device specific bcm firmware
PRODUCT_COPY_FILES += \
    $(FOSTER_BCM_PATH)/bcm4354/nvram_darcy_a00.txt:$(TARGET_COPY_OUT_VENDOR)/firmware/brcm/brcmfmac4354-sdio.nvidia,p2894-0050-a08.txt \
    $(FOSTER_BCM_PATH)/bcm4354/nvram_foster_e_4354.txt:$(TARGET_COPY_OUT_VENDOR)/firmware/brcm/brcmfmac4354-sdio.nvidia,p2571-0930.txt \
    $(FOSTER_BCM_PATH)/bcm4354/nvram_foster_e_4354.txt:$(TARGET_COPY_OUT_VENDOR)/firmware/brcm/brcmfmac4354-sdio.nvidia,p2571-0931.txt \
    $(REL30_BCM_PATH)/bcm4354/nvram_loki_e_4354.txt:$(TARGET_COPY_OUT_VENDOR)/firmware/brcm/brcmfmac4354-sdio.nvidia,p2523-0030.txt \
    $(REL30_BCM_PATH)/bcm4354/nvram_loki_e_4354.txt:$(TARGET_COPY_OUT_VENDOR)/firmware/brcm/brcmfmac4354-sdio.nvidia,p2523-0031.txt \
    $(FOSTER_BCM_PATH)/bcm4356/brcmfmac4356-pcie.txt:$(TARGET_COPY_OUT_VENDOR)/firmware/brcm/brcmfmac4356-pcie.nvidia,p2894-0050-a08.txt \
    $(FOSTER_BCM_PATH)/bcm4356/brcmfmac4356-pcie.txt:$(TARGET_COPY_OUT_VENDOR)/firmware/brcm/brcmfmac4356-pcie.nvidia,p3425-0500.txt \
    $(EXTERNAL_BCM_PATH)/bcm4356/BCM4356A2-13d3-3488.hcd:$(TARGET_COPY_OUT_VENDOR)/firmware/brcm/BCM4356A2-13d3-3488.hcd

# Upstream nvram's
PRODUCT_PACKAGES += \
    linux_firmware_brcm-bcm4354-nvidia_nvram
