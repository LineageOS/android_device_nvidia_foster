# AV
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.media.avsync=true

# Charger
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.NV_ECO.IF.CHARGING=false

# Gamestreaming specific properties
PRODUCT_PROPERTY_OVERRIDES += \
    ro.gamestream.display.optimize=1

# NRDP
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.nrdp.modelgroup=SHIELDANDROIDTV \
    ro.vendor.nrdp.audio.otfs=true \
    ro.vendor.nrdp.validation=ninja_6

# Power brick info
PRODUCT_PROPERTY_OVERRIDES += \
    persist.vendor.power.brick=PB1000

# USB configfs
PRODUCT_PROPERTY_OVERRIDES += \
    vendor.sys.usb.udc=700d0000.xudc \
    sys.usb.controller=700d0000.xudc
