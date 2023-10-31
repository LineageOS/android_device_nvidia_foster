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

# Parameters
# $1 Variant name
# $2 Config name
define thermal_config_rule
include $(CLEAR_VARS)
LOCAL_MODULE        := thermalhal.$(strip $(1)).xml
LOCAL_MODULE_TAGS   := optional
LOCAL_MODULE_CLASS  := ETC
LOCAL_SRC_FILES     := thermalhal.$(strip $(2)).xml
LOCAL_VENDOR_MODULE := true
include $(BUILD_PREBUILT)
endef

$(eval $(call thermal_config_rule, batuu,        porg   ))
$(eval $(call thermal_config_rule, darcy,        darcy  ))
$(eval $(call thermal_config_rule, dragon,       darcy  ))
$(eval $(call thermal_config_rule, foster_e,     darcy  ))
$(eval $(call thermal_config_rule, foster_e_hdd, darcy  ))
$(eval $(call thermal_config_rule, jetson_cv,    darcy  ))
$(eval $(call thermal_config_rule, jetson_e,     darcy  ))
$(eval $(call thermal_config_rule, loki_e_base,  loki_e ))
$(eval $(call thermal_config_rule, loki_e_lte,   loki_e ))
$(eval $(call thermal_config_rule, loki_e_wifi,  loki_e ))
$(eval $(call thermal_config_rule, nx,           darcy  ))
$(eval $(call thermal_config_rule, porg,         porg   ))
$(eval $(call thermal_config_rule, porg_sd,      porg   ))
$(eval $(call thermal_config_rule, sif,          darcy  ))
