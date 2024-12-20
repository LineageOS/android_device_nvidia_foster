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

FOSTER_BCM_PATH := vendor/nvidia/foster/$(TARGET_TEGRA_FIRMWARE_BRANCH)/bcm
REL30_BCM_PATH := vendor/nvidia/foster/rel-30/bcm
COMMON_EXT_PATH := vendor/nvidia/common/external/bcm
FOSTER_EXT_PATH := vendor/nvidia/foster/external/bcm

include device/nvidia/tegra-common/vendor/$(TARGET_TEGRA_FIRMWARE_BRANCH)/bcm/bcm4354.mk
include device/nvidia/tegra-common/vendor/$(TARGET_TEGRA_FIRMWARE_BRANCH)/bcm/bcm4356.mk

# Device specific bcm firmware
PRODUCT_COPY_FILES += \
    $(FOSTER_BCM_PATH)/bcm4354/darcy.clm_blob:$(TARGET_COPY_OUT_VENDOR)/firmware/bcmdhd_clm_darcy.blob \
    $(FOSTER_BCM_PATH)/bcm4354/foster.clm_blob:$(TARGET_COPY_OUT_VENDOR)/firmware/bcmdhd_clm_foster.blob \
    $(FOSTER_BCM_PATH)/bcm4354/foster.clm_blob:$(TARGET_COPY_OUT_VENDOR)/firmware/bcmdhd_clm_loki.blob \
    $(FOSTER_BCM_PATH)/bcm4356/brcmfmac4356-pcie.clm_blob:$(TARGET_COPY_OUT_VENDOR)/firmware/brcmfmac4356-pcie.clm_blob \
    $(FOSTER_BCM_PATH)/bcm4354/nvram_darcy_a00.txt:$(TARGET_COPY_OUT_VENDOR)/firmware/nvram_darcy_a00.txt \
    $(FOSTER_BCM_PATH)/bcm4354/nvram_foster_e_4354.txt:$(TARGET_COPY_OUT_VENDOR)/firmware/nvram_foster_e_4354.txt \
    $(FOSTER_BCM_PATH)/bcm4354/nvram_foster_e_antenna_tuned_4354.txt:$(TARGET_COPY_OUT_VENDOR)/firmware/nvram_foster_e_antenna_tuned_4354.txt \
    $(REL30_BCM_PATH)/bcm4354/nvram_loki_e_4354.txt:$(TARGET_COPY_OUT_VENDOR)/firmware/nvram_loki_e_4354.txt \
    $(REL30_BCM_PATH)/bcm4354/nvram_loki_e_antenna_tuned_4354.txt:$(TARGET_COPY_OUT_VENDOR)/firmware/nvram_loki_e_antenna_tuned_4354.txt \
    $(REL30_BCM_PATH)/bcm4354/nvram_jetsonE_cv_4354.txt:$(TARGET_COPY_OUT_VENDOR)/firmware/nvram_jetsonE_cv_4354.txt \
    $(FOSTER_EXT_PATH)/bcm4354/bcmdhd.cal:$(TARGET_COPY_OUT_VENDOR)/firmware/nvram_smaug_4354.txt \
    $(FOSTER_BCM_PATH)/bcm4356/brcmfmac4356-pcie.txt:$(TARGET_COPY_OUT_VENDOR)/firmware/brcmfmac4356-pcie.txt \
    $(COMMON_EXT_PATH)/bcm4356/BCM4356A2-13d3-3488.hcd:$(TARGET_COPY_OUT_VENDOR)/firmware/brcm/BCM4356A2-13d3-3488.hcd
