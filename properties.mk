# AV
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.media.avsync=true

# Charger
PRODUCT_SYSTEM_PROPERTY_OVERRIDES += \
    persist.sys.NV_ECO.IF.CHARGING=false

# Power brick info
PRODUCT_PROPERTY_OVERRIDES += \
    persist.vendor.power.brick=PB1000

# USB configfs
PRODUCT_PROPERTY_OVERRIDES += \
    vendor.sys.usb.udc=700d0000.xudc \
    sys.usb.controller=700d0000.xudc

# USB convertible port
PRODUCT_PROPERTY_OVERRIDES += \
    persist.vendor.convertible.usb.mode=host
