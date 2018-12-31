# Bluetooth
PRODUCT_PROPERTY_OVERRIDES += \
    ro.bt.bdaddr_path=/mnt/factory/bluetooth/bt_mac.txt

# NRDP
PRODUCT_PROPERTY_OVERRIDES += \
    ro.nrdp.modelgroup=SHIELDANDROIDTV \
    ro.nrdp.audio.otfs=true \
    ro.nrdp.validation=ninja_6

# WiFi
PRODUCT_PROPERTY_OVERRIDES += \
   ap.interface=wlan0 \
   wifi.direct.interface=p2p-dev-wlan0 \
   wifi.interface=wlan0
