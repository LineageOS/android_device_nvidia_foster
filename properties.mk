# AV
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.media.avsync=true

ifneq ($(TARGET_TEGRA_KERNEL),3.10)
# Bpf
PRODUCT_PROPERTY_OVERRIDES += \
    ro.kernel.ebpf.supported=1
endif

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
