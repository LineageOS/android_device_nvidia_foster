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

include $(CLEAR_VARS)
LOCAL_MODULE        := fstab.darcy
LOCAL_MODULE_CLASS  := ETC
LOCAL_SRC_FILES     := fstab.darcy
LOCAL_VENDOR_MODULE := true
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE        := fstab.foster
LOCAL_MODULE_CLASS  := ETC
LOCAL_SRC_FILES     := fstab.foster
LOCAL_VENDOR_MODULE := true
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE        := fstab.foster_e
LOCAL_MODULE_CLASS  := ETC
LOCAL_SRC_FILES     := fstab.foster_e
LOCAL_VENDOR_MODULE := true
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE        := fstab.foster_e_hdd
LOCAL_MODULE_CLASS  := ETC
LOCAL_SRC_FILES     := fstab.foster_e_hdd
LOCAL_VENDOR_MODULE := true
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE        := fstab.jetson_e
LOCAL_MODULE_CLASS  := ETC
LOCAL_SRC_FILES     := fstab.foster_e
LOCAL_VENDOR_MODULE := true
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE        := fstab.jetson_cv
LOCAL_MODULE_CLASS  := ETC
LOCAL_SRC_FILES     := fstab.foster_e
LOCAL_VENDOR_MODULE := true
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE        := fstab.sif
LOCAL_MODULE_CLASS  := ETC
LOCAL_SRC_FILES     := fstab.foster_e
LOCAL_VENDOR_MODULE := true
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE               := init.darcy.rc
LOCAL_MODULE_CLASS         := ETC
LOCAL_SRC_FILES            := init.darcy.rc
LOCAL_VENDOR_MODULE        := true
LOCAL_MODULE_RELATIVE_PATH := init/hw
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE               := init.foster_e.rc
LOCAL_MODULE_CLASS         := ETC
LOCAL_SRC_FILES            := init.foster_e.rc
LOCAL_VENDOR_MODULE        := true
LOCAL_MODULE_RELATIVE_PATH := init/hw
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE               := init.foster_e_hdd.rc
LOCAL_MODULE_CLASS         := ETC
LOCAL_SRC_FILES            := init.foster_e_hdd.rc
LOCAL_VENDOR_MODULE        := true
LOCAL_MODULE_RELATIVE_PATH := init/hw
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE               := init.jetson_e.rc
LOCAL_MODULE_CLASS         := ETC
LOCAL_SRC_FILES            := init.jetson_e.rc
LOCAL_VENDOR_MODULE        := true
LOCAL_MODULE_RELATIVE_PATH := init/hw
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE               := init.jetson_cv.rc
LOCAL_MODULE_CLASS         := ETC
LOCAL_SRC_FILES            := init.jetson_cv.rc
LOCAL_VENDOR_MODULE        := true
LOCAL_MODULE_RELATIVE_PATH := init/hw
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE               := init.sif.rc
LOCAL_MODULE_CLASS         := ETC
LOCAL_SRC_FILES            := init.sif.rc
LOCAL_VENDOR_MODULE        := true
LOCAL_MODULE_RELATIVE_PATH := init/hw
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE       := init.recovery.darcy.rc
LOCAL_MODULE_CLASS := ETC
LOCAL_SRC_FILES    := init.recovery.foster.rc
LOCAL_MODULE_PATH  := $(TARGET_ROOT_OUT)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE       := init.recovery.foster_e.rc
LOCAL_MODULE_CLASS := ETC
LOCAL_SRC_FILES    := init.recovery.foster.rc
LOCAL_MODULE_PATH  := $(TARGET_ROOT_OUT)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE       := init.recovery.foster_e_hdd.rc
LOCAL_MODULE_CLASS := ETC
LOCAL_SRC_FILES    := init.recovery.foster.rc
LOCAL_MODULE_PATH  := $(TARGET_ROOT_OUT)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE       := init.recovery.jetson_cv.rc
LOCAL_MODULE_CLASS := ETC
LOCAL_SRC_FILES    := init.recovery.foster.rc
LOCAL_MODULE_PATH  := $(TARGET_ROOT_OUT)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE       := init.recovery.jetson_e.rc
LOCAL_MODULE_CLASS := ETC
LOCAL_SRC_FILES    := init.recovery.foster.rc
LOCAL_MODULE_PATH  := $(TARGET_ROOT_OUT)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE       := init.recovery.sif.rc
LOCAL_MODULE_CLASS := ETC
LOCAL_SRC_FILES    := init.recovery.foster.rc
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
LOCAL_MODULE               := init.loki_foster_e_common.rc
LOCAL_MODULE_CLASS         := ETC
LOCAL_SRC_FILES            := init.loki_foster_e_common.rc
LOCAL_VENDOR_MODULE        := true
LOCAL_MODULE_RELATIVE_PATH := init/hw
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE       := power.darcy.rc
LOCAL_MODULE_CLASS := ETC
LOCAL_ODM_MODULE   := true
LOCAL_SRC_FILES    := power.darcy.rc
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE       := power.foster_e.rc
LOCAL_MODULE_CLASS := ETC
LOCAL_ODM_MODULE   := true
LOCAL_SRC_FILES    := power.foster_e_common.rc
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE       := power.foster_e_hdd.rc
LOCAL_MODULE_CLASS := ETC
LOCAL_ODM_MODULE   := true
LOCAL_SRC_FILES    := power.foster_e_common.rc
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE       := power.jetson_cv.rc
LOCAL_MODULE_CLASS := ETC
LOCAL_ODM_MODULE   := true
LOCAL_SRC_FILES    := power.foster_e_common.rc
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE       := power.jetson_e.rc
LOCAL_MODULE_CLASS := ETC
LOCAL_ODM_MODULE   := true
LOCAL_SRC_FILES    := power.foster_e_common.rc
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE       := power.sif.rc
LOCAL_MODULE_CLASS := ETC
LOCAL_ODM_MODULE   := true
LOCAL_SRC_FILES    := power.darcy.rc
include $(BUILD_PREBUILT)
