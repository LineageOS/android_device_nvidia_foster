# Inherit device configuration for foster.
$(call inherit-product, device/nvidia/foster/full_foster.mk)

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_tablet_wifionly.mk)

PRODUCT_NAME := cm_foster
PRODUCT_DEVICE := foster
