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

LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE        := audio_effects.xml
LOCAL_MODULE_TAGS   := optional
LOCAL_MODULE_CLASS  := ETC
LOCAL_SRC_FILES     := audio_effects.xml
LOCAL_VENDOR_MODULE := true
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE        := audio_policy_configuration.xml
LOCAL_MODULE_TAGS   := optional
LOCAL_MODULE_CLASS  := ETC
LOCAL_SRC_FILES     := audio_policy_configuration.xml
LOCAL_VENDOR_MODULE := true
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE               := audio_policy_configuration_dragon.xml
LOCAL_MODULE_STEM          := audio_policy_configuration.xml
LOCAL_MODULE_TAGS          := optional
LOCAL_MODULE_CLASS         := ETC
LOCAL_SRC_FILES            := audio_policy_configuration_loki.xml
LOCAL_VENDOR_MODULE        := true
LOCAL_MODULE_RELATIVE_PATH := audio/sku_dragon
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE               := audio_policy_configuration_loki.xml
LOCAL_MODULE_STEM          := audio_policy_configuration.xml
LOCAL_MODULE_TAGS          := optional
LOCAL_MODULE_CLASS         := ETC
LOCAL_SRC_FILES            := audio_policy_configuration_loki.xml
LOCAL_VENDOR_MODULE        := true
LOCAL_MODULE_RELATIVE_PATH := audio/sku_loki
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE               := audio_policy_configuration_nx.xml
LOCAL_MODULE_STEM          := audio_policy_configuration.xml
LOCAL_MODULE_TAGS          := optional
LOCAL_MODULE_CLASS         := ETC
LOCAL_SRC_FILES            := audio_policy_configuration_nx.xml
LOCAL_VENDOR_MODULE        := true
LOCAL_MODULE_RELATIVE_PATH := audio/sku_nx
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE        := dragon_nvaudio_conf.xml
LOCAL_MODULE_TAGS   := optional
LOCAL_MODULE_CLASS  := ETC
LOCAL_SRC_FILES     := dragon_nvaudio_conf.xml
LOCAL_VENDOR_MODULE := true
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE        := nx_nvaudio_conf.xml
LOCAL_MODULE_TAGS   := optional
LOCAL_MODULE_CLASS  := ETC
LOCAL_SRC_FILES     := nx_nvaudio_conf.xml
LOCAL_VENDOR_MODULE := true
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE        := loki_e_base_nvaudio_conf.xml
LOCAL_MODULE_TAGS   := optional
LOCAL_MODULE_CLASS  := ETC
LOCAL_SRC_FILES     := loki_nvaudio_conf.xml
LOCAL_VENDOR_MODULE := true
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE        := loki_e_lte_nvaudio_conf.xml
LOCAL_MODULE_TAGS   := optional
LOCAL_MODULE_CLASS  := ETC
LOCAL_SRC_FILES     := loki_nvaudio_conf.xml
LOCAL_VENDOR_MODULE := true
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE        := loki_e_wifi_nvaudio_conf.xml
LOCAL_MODULE_TAGS   := optional
LOCAL_MODULE_CLASS  := ETC
LOCAL_SRC_FILES     := loki_nvaudio_conf.xml
LOCAL_VENDOR_MODULE := true
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE        := nvaudio_conf.xml
LOCAL_MODULE_TAGS   := optional
LOCAL_MODULE_CLASS  := ETC
LOCAL_SRC_FILES     := nvaudio_conf.xml
LOCAL_VENDOR_MODULE := true
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE        := nvaudio_fx.xml
LOCAL_MODULE_TAGS   := optional
LOCAL_MODULE_CLASS  := ETC
LOCAL_SRC_FILES     := nvaudio_fx.xml
LOCAL_VENDOR_MODULE := true
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE        := media_codecs.xml
LOCAL_MODULE_TAGS   := optional
LOCAL_MODULE_CLASS  := ETC
ifneq (,$(findstring nvmm,$(TARGET_TEGRA_OMX)))
LOCAL_SRC_FILES     := media_codecs.xml
else
LOCAL_SRC_FILES     := media_codecs_sw.xml
endif
LOCAL_ODM_MODULE    := true
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE        := media_codecs_performance.xml
LOCAL_MODULE_TAGS   := optional
LOCAL_MODULE_CLASS  := ETC
LOCAL_SRC_FILES     := media_codecs_performance.xml
LOCAL_ODM_MODULE    := true
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE        := media_profiles_V1_0.xml
LOCAL_MODULE_TAGS   := optional
LOCAL_MODULE_CLASS  := ETC
LOCAL_SRC_FILES     := media_profiles_V1_0.xml
LOCAL_VENDOR_MODULE := true
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE        := enctune.conf
LOCAL_MODULE_TAGS   := optional
LOCAL_MODULE_CLASS  := ETC
LOCAL_SRC_FILES     := enctune.conf
LOCAL_VENDOR_MODULE := true
include $(BUILD_PREBUILT)
