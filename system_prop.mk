# Bluetooth
PRODUCT_PROPERTY_OVERRIDES += \
    ro.bt.bdaddr_path=/mnt/factory/bluetooth/bt_mac.txt

# HDMI
PRODUCT_PROPERTY_OVERRIDES += \
    ro.hdmi.device_type=4 \
    ro.hdmi.one_touch_play_on_home=0 \
    persist.sys.hdmi.keep_awake=0 \
    ro.hdmi.wake_on_hotplug=0

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
