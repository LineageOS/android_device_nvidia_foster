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

include device/nvidia/t210-common/vendor/t210-by-flags.mk
include device/nvidia/tegra-common/vendor/common-by-flags.mk
include device/nvidia/shield-common/vendor/shield-by-flags.mk

ifneq ("$(wildcard device/nvidia/foster/vendor/$(TARGET_TEGRA_FIRMWARE_BRANCH)/bcm/bcm.mk)","")
include device/nvidia/foster/vendor/$(TARGET_TEGRA_FIRMWARE_BRANCH)/bcm/bcm.mk
include device/nvidia/tegra-common/vendor/$(TARGET_TEGRA_FIRMWARE_BRANCH)/bcm/bcm4354.mk
include device/nvidia/tegra-common/vendor/$(TARGET_TEGRA_FIRMWARE_BRANCH)/bcm/bcm4356.mk
include device/nvidia/tegra-common/vendor/$(TARGET_TEGRA_FIRMWARE_BRANCH)/realtek/rtl8153a-3.mk
else ifneq ("$(wildcard device/nvidia/foster/vendor/$(TARGET_TEGRA_DEFAULT_BRANCH)/bcm_firmware/bcm.mk)","")
include device/nvidia/foster/vendor/$(TARGET_TEGRA_DEFAULT_BRANCH)/bcm_firmware/bcm.mk

# This needs a better check. Assumption is that when firmware is from rel-shield-r, nvgpu is in use.
PRODUCT_PACKAGES += public.libraries
endif
