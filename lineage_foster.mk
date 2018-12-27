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

# Inherit device configuration for foster.
$(call inherit-product, device/nvidia/foster/full_foster.mk)

# Inherit some common lineage stuff.
$(call inherit-product, vendor/lineage/config/common_full_tv.mk)

PRODUCT_NAME := lineage_foster
PRODUCT_DEVICE := foster
