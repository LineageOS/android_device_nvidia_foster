# NRDP
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.nrdp.modelgroup=SHIELDANDROIDTV \
    ro.vendor.nrdp.audio.otfs=true \
    ro.vendor.nrdp.validation=ninja_6

# USB configfs
PRODUCT_PROPERTY_OVERRIDES += \
    vendor.sys.usb.udc=700d0000.xudc \
    sys.usb.controller=700d0000.xudc

# WiFi
PRODUCT_PROPERTY_OVERRIDES += \
   ap.interface=wlan0 \
   wifi.direct.interface=p2p-dev-wlan0 \
   wifi.interface=wlan0
