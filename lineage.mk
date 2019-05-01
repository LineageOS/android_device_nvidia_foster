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

TARGET_TEGRA_POWER ?= lineage

# Unified device support
TARGET_INIT_VENDOR_LIB := libinit_foster
PRODUCT_VENDOR_PROPERTY_BLACKLIST := \
    ro.product.vendor.device \
    ro.product.vendor.model \
    ro.product.vendor.name \
    ro.vendor.build.fingerprint
PRODUCT_PACKAGES += \
    init_tegra
