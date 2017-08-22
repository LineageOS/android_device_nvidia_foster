# Inherit device configuration for foster.
$(call inherit-product, device/nvidia/foster/full_foster.mk)

# Inherit some common lineage stuff.
ifeq ($(ALTERNATE_BUILD),true)
$(call inherit-product, vendor/lineage/config/common_full_tablet_wifionly.mk)
else
$(call inherit-product, vendor/lineage/config/common_full_tv.mk)
endif

PRODUCT_NAME := lineage_foster
PRODUCT_DEVICE := foster
