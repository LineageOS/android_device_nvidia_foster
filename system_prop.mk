# Bluetooth
PRODUCT_PROPERTY_OVERRIDES += \
    ro.bt.bdaddr_path=/mnt/factory/bluetooth/bt_mac.txt

# Gamestreaming specific properties
PRODUCT_PROPERTY_OVERRIDES += \
    ro.gamestream.display.optimize=1

# NRDP
PRODUCT_PROPERTY_OVERRIDES += \
    ro.nrdp.modelgroup=SHIELDANDROIDTV \
    ro.nrdp.audio.otfs=true \
    ro.nrdp.validation=ninja_6

# USB configfs
PRODUCT_PROPERTY_OVERRIDES += \
    sys.usb.udc=700d0000.xudc \
    sys.usb.controller=700d0000.xudc

# WiFi
PRODUCT_PROPERTY_OVERRIDES += \
   ap.interface=wlan0 \
   wifi.direct.interface=p2p-dev-wlan0 \
   wifi.interface=wlan0
