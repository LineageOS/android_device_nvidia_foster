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

LOCAL_PATH := $(call my-dir)
DOWNSTREAM_BRANCH      := rel-shield-r
NV_TEGRA_BRANCH        := rel-30
COMMON_DOWNSTREAM_PATH := ../../../../../../vendor/nvidia/common/$(DOWNSTREAM_BRANCH)/bcm_firmware
FOSTER_DOWNSTREAM_PATH := ../../../../../../vendor/nvidia/foster/$(DOWNSTREAM_BRANCH)/bcm_firmware
FOSTER_NV_TEGRA_PATH   := ../../../../../../vendor/nvidia/foster/$(NV_TEGRA_BRANCH)/bcm_firmware

include $(CLEAR_VARS)
LOCAL_MODULE               := bcm4350.hcd
LOCAL_SRC_FILES            := $(COMMON_DOWNSTREAM_PATH)/bcm4354/BCM4350C0.hcd
LOCAL_MODULE_CLASS         := ETC
LOCAL_MODULE_PATH          := $(TARGET_OUT_VENDOR)/firmware/brcm
LOCAL_MODULE_TAGS          := optional
LOCAL_MODULE_OWNER         := nvidia
LOCAL_MODULE_SYMLINKS      := BCM4354.nvidia,p2371-2180.hcd BCM4354.nvidia,p2371-0000.hcd BCM4354.nvidia,foster_e.hcd BCM4354.nvidia,foster_e_hdd.hcd BCM4354.nvidia,darcy.hcd BCM4354.nvidia,loki_e_base.hcd BCM4354.nvidia,loki_e_lte.hcd BCM4354.nvidia,loki_e_wifi.hcd
include $(BUILD_NVIDIA_COMMON_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE               := bcm4356.hcd
LOCAL_SRC_FILES            := $(COMMON_DOWNSTREAM_PATH)/bcm4356/BCM4356A3.hcd
LOCAL_MODULE_CLASS         := ETC
LOCAL_MODULE_PATH          := $(TARGET_OUT_VENDOR)/firmware/brcm
LOCAL_MODULE_TAGS          := optional
LOCAL_MODULE_OWNER         := nvidia
LOCAL_MODULE_SYMLINKS      := BCM4356.nvidia,darcy.hcd BCM4356.nvidia,sif.hcd
include $(BUILD_NVIDIA_COMMON_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE               := nvram_jetsonE_cv_4354.txt
LOCAL_SRC_FILES            := $(FOSTER_NV_TEGRA_PATH)/bcm4354/nvram_jetsonE_cv_4354.txt
LOCAL_MODULE_CLASS         := ETC
LOCAL_MODULE_PATH          := $(TARGET_OUT_VENDOR)/firmware/brcm
LOCAL_MODULE_TAGS          := optional
LOCAL_MODULE_OWNER         := nvidia
LOCAL_MODULE_SYMLINKS      := brcmfmac4354-sdio.nvidia,p2371-2180.txt brcmfmac4354-sdio.nvidia,p2371-0000.txt
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE               := nvram_loki_e_4354.txt
LOCAL_SRC_FILES            := $(FOSTER_NV_TEGRA_PATH)/bcm4354/nvram_loki_e_4354.txt
LOCAL_MODULE_CLASS         := ETC
LOCAL_MODULE_PATH          := $(TARGET_OUT_VENDOR)/firmware/brcm
LOCAL_MODULE_TAGS          := optional
LOCAL_MODULE_OWNER         := nvidia
LOCAL_MODULE_SYMLINKS      := brcmfmac4354-sdio.nvidia,loki_e_base.txt brcmfmac4354-sdio.nvidia,loki_e_lte.txt brcmfmac4354-sdio.nvidia,loki_e_wifi.txt
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE               := nvram_foster_e_4354.txt
LOCAL_SRC_FILES            := $(FOSTER_DOWNSTREAM_PATH)/bcm4354/nvram_foster_e_4354.txt
LOCAL_MODULE_CLASS         := ETC
LOCAL_MODULE_PATH          := $(TARGET_OUT_VENDOR)/firmware/brcm
LOCAL_MODULE_TAGS          := optional
LOCAL_MODULE_OWNER         := nvidia
LOCAL_MODULE_SYMLINKS      := brcmfmac4354-sdio.nvidia,foster_e.txt brcmfmac4354-sdio.nvidia,foster_e_hdd.txt
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE               := nvram_darcy_a00.txt
LOCAL_SRC_FILES            := $(FOSTER_DOWNSTREAM_PATH)/bcm4354/nvram_darcy_a00.txt
LOCAL_MODULE_CLASS         := ETC
LOCAL_MODULE_PATH          := $(TARGET_OUT_VENDOR)/firmware/brcm
LOCAL_MODULE_TAGS          := optional
LOCAL_MODULE_OWNER         := nvidia
LOCAL_MODULE_SYMLINKS      := brcmfmac4354-sdio.nvidia,darcy.txt
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE               := brcmfmac4356-pcie.txt
LOCAL_SRC_FILES            := $(FOSTER_DOWNSTREAM_PATH)/bcm4356/brcmfmac4356-pcie.txt
LOCAL_MODULE_CLASS         := ETC
LOCAL_MODULE_PATH          := $(TARGET_OUT_VENDOR)/firmware/brcm
LOCAL_MODULE_TAGS          := optional
LOCAL_MODULE_OWNER         := nvidia
LOCAL_MODULE_SYMLINKS      := brcmfmac4356-pcie.nvidia,darcy.txt brcmfmac4356-pcie.nvidia,sif.txt
include $(BUILD_PREBUILT)
