# Copyright (C) 2019 The LineageOS Project
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

# Parameters
# $1 Variant name
# $2 Fstab source
# $3 Init rc name
# $4 Recovery rc name
# $5 Power rc name 
define initfiles_rule
include $(CLEAR_VARS)
LOCAL_MODULE           := fstab.$(strip $(1))
LOCAL_MODULE_CLASS     := ETC
LOCAL_SRC_FILES        := fstab.$(strip $(2))
LOCAL_VENDOR_MODULE    := true
LOCAL_REQUIRED_MODULES := fstab.$(strip $(1))_ramdisk
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE        := fstab.$(strip $(1))_ramdisk
LOCAL_MODULE_STEM   := fstab.$(strip $(1))
LOCAL_MODULE_CLASS  := ETC
LOCAL_SRC_FILES     := fstab.$(strip $(2))
LOCAL_MODULE_PATH   := $(TARGET_RAMDISK_OUT)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE               := init.$(strip $(1)).rc
LOCAL_MODULE_CLASS         := ETC
LOCAL_SRC_FILES            := init.$(strip $(3)).rc
LOCAL_VENDOR_MODULE        := true
LOCAL_MODULE_RELATIVE_PATH := init/hw
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE       := init.recovery.$(strip $(1)).rc
LOCAL_MODULE_CLASS := ETC
LOCAL_SRC_FILES    := init.recovery.$(strip $(4)).rc
LOCAL_MODULE_PATH  := $(TARGET_ROOT_OUT)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE       := power.$(strip $(1)).rc
LOCAL_MODULE_CLASS := ETC
LOCAL_ODM_MODULE   := true
LOCAL_SRC_FILES    := power.$(strip $(5)).rc
include $(BUILD_PREBUILT)
endef

$(eval $(call initfiles_rule, batuu,        sd,     batuu,        foster, darcy           ))
$(eval $(call initfiles_rule, darcy,        emmc,   darcy,        darcy,  darcy           ))
$(eval $(call initfiles_rule, dragon,       dragon, dragon,       dragon, abca            ))
$(eval $(call initfiles_rule, foster_e,     emmc,   foster_e,     foster, foster_e_common ))
$(eval $(call initfiles_rule, foster_e_hdd, emmc,   foster_e_hdd, foster, foster_e_common ))
$(eval $(call initfiles_rule, jetson_cv,    emmc,   jetson_cv,    foster, foster_e_common ))
$(eval $(call initfiles_rule, jetson_e,     emmc,   jetson_e,     foster, foster_e_common ))
$(eval $(call initfiles_rule, loki_e_base,  emmc,   loki_e,       loki,   loki_e_common   ))
$(eval $(call initfiles_rule, loki_e_lte,   emmc,   loki_e,       loki,   loki_e_common   ))
$(eval $(call initfiles_rule, loki_e_wifi,  emmc,   loki_e,       loki,   loki_e_common   ))
$(eval $(call initfiles_rule, nx,           nx,     nx,           nx,     nx              ))
$(eval $(call initfiles_rule, porg,         emmc,   porg,         foster, darcy           ))
$(eval $(call initfiles_rule, porg_sd,      sd,     porg_sd,      foster, darcy           ))
$(eval $(call initfiles_rule, sif,          emmc,   sif,          sif,    darcy           ))

include $(CLEAR_VARS)
LOCAL_MODULE       := init.recovery.foster_common.rc
LOCAL_MODULE_CLASS := ETC
LOCAL_SRC_FILES    := init.recovery.foster_common.rc
LOCAL_MODULE_PATH  := $(TARGET_ROOT_OUT)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE               := init.foster_e_common.rc
LOCAL_MODULE_CLASS         := ETC
LOCAL_SRC_FILES            := init.foster_e_common.rc
LOCAL_VENDOR_MODULE        := true
LOCAL_MODULE_RELATIVE_PATH := init/hw
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE               := init.loki_e_common.rc
LOCAL_MODULE_CLASS         := ETC
LOCAL_SRC_FILES            := init.loki_e_common.rc
LOCAL_VENDOR_MODULE        := true
LOCAL_MODULE_RELATIVE_PATH := init/hw
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE               := init.loki_foster_e_common.rc
LOCAL_MODULE_CLASS         := ETC
LOCAL_SRC_FILES            := init.loki_foster_e_common.rc
LOCAL_VENDOR_MODULE        := true
LOCAL_MODULE_RELATIVE_PATH := init/hw
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE        := lkm_loader_target
LOCAL_SRC_FILES     := lkm_loader_target.sh
LOCAL_MODULE_SUFFIX := .sh
LOCAL_MODULE_CLASS  := EXECUTABLES
LOCAL_VENDOR_MODULE := true
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE               := init.eks2.rc
LOCAL_MODULE_CLASS         := ETC
LOCAL_SRC_FILES            := init.eks2.rc
LOCAL_VENDOR_MODULE        := true
LOCAL_MODULE_RELATIVE_PATH := init
LOCAL_REQUIRED_MODULES     := eks2_symlink
include $(BUILD_PREBUILT)
