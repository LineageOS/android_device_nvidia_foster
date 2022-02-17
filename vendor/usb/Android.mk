# Copyright (C) 2020 The LineageOS Project
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
FOSTER_USB_PATH := ../../../../../vendor/nvidia/foster/usb

include $(CLEAR_VARS)
LOCAL_MODULE               := vendor.nvidia.hardware.convertibleport@1.0-service
LOCAL_VINTF_FRAGMENTS      := vendor.nvidia.hardware.convertibleport@1.0-service.xml
LOCAL_INIT_RC              := etc/init/vendor.nvidia.hardware.convertibleport@1.0-service.rc
LOCAL_SRC_FILES_32         := $(FOSTER_USB_PATH)/bin32/hw/vendor.nvidia.hardware.convertibleport@1.0-service
LOCAL_SRC_FILES_64         := $(FOSTER_USB_PATH)/bin64/hw/vendor.nvidia.hardware.convertibleport@1.0-service
LOCAL_MULTILIB             := first
LOCAL_MODULE_CLASS         := EXECUTABLES
LOCAL_MODULE_TAGS          := optional
LOCAL_MODULE_OWNER         := nvidia
LOCAL_VENDOR_MODULE        := true
LOCAL_MODULE_RELATIVE_PATH := hw
include $(BUILD_NVIDIA_PREBUILT)
