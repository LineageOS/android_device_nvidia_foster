#
# Copyright (C) 2022-2023 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Gpu driver
ifeq ($(TARGET_TEGRA_GPU),nvgpu)
BOARD_VENDOR_KERNEL_MODULES_LOAD += \
    governor_pod_scaling \
    nvgpu
else
BOARD_VENDOR_KERNEL_MODULES_LOAD += \
    nouveau
endif

# Tegra high speed serial
BOARD_VENDOR_KERNEL_MODULES_LOAD += \
    serial-tegra

# Usb Bluetooth
BOARD_VENDOR_KERNEL_MODULES_LOAD += \
    btusb

# Broadcom wifi
BOARD_VENDOR_KERNEL_MODULES_LOAD += \
    brcmfmac-wcc

# Realtek ethernet
BOARD_VENDOR_KERNEL_MODULES_LOAD += \
    r8169

# Tegra cec
BOARD_VENDOR_KERNEL_MODULES_LOAD += \
    tegra_cec

# Tegra hdmi audio
BOARD_VENDOR_KERNEL_MODULES_LOAD += \
    snd-hda-codec-hdmi \
    snd-hda-tegra

# Tegra audio processing engine
BOARD_VENDOR_KERNEL_MODULES_LOAD += \
    tegra-aconnect \
    tegra210-adma \
    snd-soc-tegra210-sfc \
    snd-soc-tegra210-i2s \
    snd-soc-tegra210-mixer \
    snd-soc-tegra210-amx \
    snd-soc-tegra210-admaif \
    snd-soc-tegra210-adx \
    snd-soc-tegra210-iqc \
    snd-soc-tegra210-afc \
    snd-soc-tegra210-dmic \
    snd-soc-tegra210-mvc \
    snd-soc-tegra210-ope \
    snd-soc-tegra-audio-graph-card

# Nvidia Controllers
BOARD_VENDOR_KERNEL_MODULES_LOAD += \
    hid-nvidia-shield \
    hid-nvidia-shield-oot

# Raydium touchscreen
BOARD_VENDOR_KERNEL_MODULES_LOAD += \
    rm31080a_ctrl \
    rm31080a_ts

# Copy to boot
BOOT_KERNEL_MODULES := \
    system_heap.ko \
    tegra30-devfreq.ko \
    cpufreq-dt.ko \
    tegra124-cpufreq.ko \
    i2c-tegra.ko \
    spi-tegra114.ko \
    spi-tegra210-quad.ko \
    bq24190_charger.ko \
    bq27xxx_battery.ko \
    bq27xxx_battery_i2c.ko \
    rtc-tegra.ko \
    gpio-tegra.ko \
    max77620.ko \
    gpio-max77620.ko \
    pinctrl-max77620.ko \
    max77620-regulator.ko \
    rtc-max77686.ko \
    max77812-regulator.ko \
    gpio-pca953x.ko \
    tegra20-apb-dma.ko \
    tegra210-emc.ko \
    phy-tegra-xusb.ko \
    xhci-tegra.ko \
    tegra-xudc.ko \
    usb-conn-gpio.ko \
    pci-tegra.ko \
    hwmon.ko \
    pwm-tegra.ko \
    pwm-fan.ko \
    pwm-regulator.ko \
    tegra-soctherm.ko \
    lm90.ko \
    cqhci.ko \
    sdhci-tegra.ko \
    simplefb.ko \
    host1x.ko \
    drm_display_helper.ko \
    drm_dp_aux_bus.ko \
    tegra-drm.ko \
    panel-jdi-58-1440-810.ko \
    pwm_bl.ko

ifeq ($(TARGET_TEGRA_TOS),trusty)
BOOT_KERNEL_MODULES += \
    ffa-core.ko \
    ffa-module.ko \
    trusty-core.ko \
    trusty-ffa.ko \
    trusty-ipc.ko \
    trusty-log.ko \
    trusty-populate.ko \
    trusty-smc.ko \
    trusty-test.ko \
    trusty-virtio.ko \
    trusty-virtio-polling.ko
endif

# Load in first stage boot
BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD := \
    system_heap \
    tegra30-devfreq \
    tegra124-cpufreq \
    i2c-tegra \
    spi-tegra114 \
    spi-tegra210-quad \
    bq24190_charger \
    bq27xxx_battery_i2c \
    rtc-tegra \
    gpio-tegra \
    max77620 \
    gpio-max77620 \
    pinctrl-max77620 \
    max77620-regulator \
    max77812-regulator \
    gpio-pca953x \
    tegra20-apb-dma \
    tegra210-emc \
    xhci-tegra \
    tegra-xudc \
    usb-conn-gpio \
    pci-tegra \
    pwm-tegra \
    pwm-fan \
    pwm-regulator \
    tegra-soctherm \
    lm90 \
    sdhci-tegra \
    simplefb \
    tegra-drm \
    panel-jdi-58-1440-810 \
    pwm_bl

ifeq ($(TARGET_TEGRA_TOS),trusty)
BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD += \
    trusty-smc \
    trusty-log \
    trusty-ipc \
    trusty-virtio
endif


# Copy to recovery
RECOVERY_KERNEL_MODULES := \
    $(BOOT_KERNEL_MODULES) \
    hid-nvidia-shield.ko \
    hid-nvidia-shield-oot.ko \
    rm31080a_ctrl.ko \
    rm31080a_ts.ko

# Load in recovery
BOARD_RECOVERY_KERNEL_MODULES_LOAD := \
    $(BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD) \
    hid-nvidia-shield \
    hid-nvidia-shield-oot \
    rm31080a_ts
