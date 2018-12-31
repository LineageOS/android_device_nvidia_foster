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

# USB Vendor and Product ID Definition
PRODUCT_PROPERTY_OVERRIDES += \
    ro.nv.usb.vid=0955 \
    ro.nv.usb.pid.mtp=B430 \
    ro.nv.usb.pid.mtp.adb=B431 \
    ro.nv.usb.pid.rndis=B434 \
    ro.nv.usb.pid.rndis.acm.adb=af00 \
    ro.nv.usb.pid.rndis.adb=B435 \
    ro.nv.usb.pid.ptp=B432 \
    ro.nv.usb.pid.ptp.adb=B433 \
    ro.nv.usb.pid.adb=7104 \
    ro.nv.usb.pid.accessory.adb=7105 \
    ro.nv.usb.pid.audio_source.adb=7106 \
    ro.nv.usb.pid.ncm=7107 \
    ro.nv.usb.pid.ncm.adb=7108 \
    ro.nv.usb.pid.ecm=710B \
    ro.nv.usb.pid.ecm.adb=710C \
    ro.nv.usb.pid.midi=7109 \
    ro.nv.usb.pid.midi.adb=710A

# WiFi
PRODUCT_PROPERTY_OVERRIDES += \
   ap.interface=wlan0 \
   wifi.direct.interface=p2p-dev-wlan0 \
   wifi.interface=wlan0
