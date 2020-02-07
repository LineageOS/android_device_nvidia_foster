# Copyright (C) 2019 The LineageOS Project
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

""" Custom OTA commands for foster devices """

import common
import re
import os

APP_PART     = '/dev/block/by-name/APP'
DTB_PART     = '/dev/block/by-name/DTB'
STAGING_PART = '/dev/block/by-name/USP'
VENDOR_PART  = '/dev/block/by-name/vendor'

PUBLIC_KEY_PATH     = '/sys/devices/7000f800.efuse/7000f800.efuse:efuse-burn/public_key'
FUSED_PATH          = '/sys/devices/7000f800.efuse/7000f800.efuse:efuse-burn/odm_production_mode'
DTSFILENAME_PATH    = '/proc/device-tree/nvidia,dtsfilename'

MODE_UNFUSED        = '0x00000000\n'
MODE_FUSED          = '0x00000001\n'

FOSTER_E_PUBLIC_KEY = '0x0256ff42f60a5159edad8029772f1d5f848477fb9d33cd2b2e8f0b4d85c8d78a\n'
FOSTER_E_BL_VERSION = '32.00.2019.50-t210-62176168'

LOKI_E_PUBLIC_KEY   = '0x4261f1714a7d71c7e810c9b33769878128cc54ae3c5736646496104b643aed09\n'
LOKI_E_BL_VERSION   = '24.00.2015.42-t210-39c6cadc' # the last released signed bootloader

DARCY_PUBLIC_KEY    = '0x435a807e9187c53eae50e2dcab521e0ea41458a9b18d31db553ceb711c21fb52\n'
DARCY_BL_VERSION    = '32.00.2019.50-t210-79558a05'

def FullOTA_PostValidate(info):
  if 'INSTALL/bin/resize2fs_static' in info.input_zip.namelist():
    info.script.AppendExtra('run_program("/tmp/install/bin/resize2fs_static", "' + APP_PART + '");');
    info.script.AppendExtra('run_program("/tmp/install/bin/resize2fs_static", "' + VENDOR_PART + '");');

def FullOTA_Assertions(info):
  if 'RADIO/foster_e.blob' in info.input_zip.namelist():
    CopyBlobs(info.input_zip, info.output_zip)
    AddBootloaderFlash(info, info.input_zip)
  else:
    AddBootloaderAssertion(info, info.input_zip)

def IncrementalOTA_Assertions(info):
  FullOTA_Assertions(info)

def CopyBlobs(input_zip, output_zip):
  for info in input_zip.infolist():
    f = info.filename
    if f.startswith("RADIO/") and (f.__len__() > len("RADIO/")):
      fn = f[6:]
      common.ZipWriteStr(output_zip, "firmware-update/" + fn, input_zip.read(f))

def AddBootloaderAssertion(info, input_zip):
  android_info = input_zip.read("OTA/android-info.txt").decode('utf-8')
  m = re.search(r"require\s+version-bootloader\s*=\s*(\S+)", android_info)
  if m:
    bootloaders = m.group(1).split("|")
    if "*" not in bootloaders:
      info.script.AssertSomeBootloader(*bootloaders)
    info.metadata["pre-bootloader"] = m.group(1)

def AddBootloaderFlash(info, input_zip):
  """ If device is fused """
  info.script.AppendExtra('ifelse(')
  info.script.AppendExtra('  read_file("' + FUSED_PATH + '") == "' + MODE_FUSED + '",')
  info.script.AppendExtra('  (')

  """ Fused foster_e or foster_e_hdd """
  info.script.AppendExtra('    ifelse(')
  info.script.AppendExtra('      getprop("ro.hardware") == "foster_e" || getprop("ro.hardware") == "foster_e_hdd",')
  info.script.AppendExtra('      (')
  info.script.AppendExtra('        ifelse(')
  info.script.AppendExtra('          getprop("ro.bootloader") == "' + FOSTER_E_BL_VERSION + '",')
  info.script.AppendExtra('          (')
  info.script.AppendExtra('            ui_print("Correct bootloader already installed for fused " + getprop(ro.hardware));')
  info.script.AppendExtra('          ),')
  info.script.AppendExtra('          ifelse(')
  info.script.AppendExtra('            read_file("' + PUBLIC_KEY_PATH + '") == "' + FOSTER_E_PUBLIC_KEY + '",')
  info.script.AppendExtra('            (')
  info.script.AppendExtra('              ui_print("Flashing updated bootloader for fused " + getprop(ro.hardware));')
  info.script.AppendExtra('              package_extract_file("firmware-update/" + getprop(ro.hardware) + ".blob", "' + STAGING_PART + '");')
  info.script.AppendExtra('            ),')
  info.script.AppendExtra('            (')
  info.script.AppendExtra('              ui_print("Unknown public key " + read_file("' + PUBLIC_KEY_PATH + '") + " for " + getprop("ro.hardware") + " detected.");')
  info.script.AppendExtra('              ui_print("This is not supported. Please report to LineageOS Maintainer.");')
  info.script.AppendExtra('              abort();')
  info.script.AppendExtra('            )')
  info.script.AppendExtra('          )')
  info.script.AppendExtra('        );')
  info.script.AppendExtra('        package_extract_file("install/" + tegra_get_dtbname(), "' + DTB_PART + '");')
  info.script.AppendExtra('      )')
  info.script.AppendExtra('    );')

  """ Fused darcy """
  info.script.AppendExtra('    ifelse(')
  info.script.AppendExtra('      getprop("ro.hardware") == "darcy",')
  info.script.AppendExtra('      (')
  info.script.AppendExtra('        ifelse(')
  info.script.AppendExtra('          is_substring("tegra210b01", read_file("' + DTSFILENAME_PATH + '")),')
  """ mdarcy """
  info.script.AppendExtra('          (')
  info.script.AppendExtra('            ui_print("MDarcy is not supported in this build.");')
  info.script.AppendExtra('            abort();')
  info.script.AppendExtra('          ),')
  """ darcy """
  info.script.AppendExtra('          (')
  info.script.AppendExtra('            ifelse(')
  info.script.AppendExtra('              getprop("ro.bootloader") == "' + DARCY_BL_VERSION + '",')
  info.script.AppendExtra('              (')
  info.script.AppendExtra('                ui_print("Correct bootloader already installed for fused darcy");')
  info.script.AppendExtra('              ),')
  info.script.AppendExtra('              (')
  info.script.AppendExtra('                ifelse(')
  info.script.AppendExtra('                  read_file("' + PUBLIC_KEY_PATH + '") == "' + DARCY_PUBLIC_KEY + '",')
  info.script.AppendExtra('                  (')
  info.script.AppendExtra('                    ui_print("Flashing updated bootloader for fused darcy");')
  info.script.AppendExtra('                    package_extract_file("firmware-update/darcy.blob", "' + STAGING_PART + '");')
  info.script.AppendExtra('                  ),')
  info.script.AppendExtra('                  (')
  info.script.AppendExtra('                    ui_print("Unknown public key " + read_file("' + PUBLIC_KEY_PATH + '") + " for darcy detected.");')
  info.script.AppendExtra('                    ui_print("This is not supported. Please report to LineageOS Maintainer.");')
  info.script.AppendExtra('                    abort();')
  info.script.AppendExtra('                  )')
  info.script.AppendExtra('                );')
  info.script.AppendExtra('              )')
  info.script.AppendExtra('            );')
  info.script.AppendExtra('            package_extract_file("install/" + tegra_get_dtbname(), "' + DTB_PART + '");')
  info.script.AppendExtra('          )')
  info.script.AppendExtra('        )')
  info.script.AppendExtra('      )')
  info.script.AppendExtra('    );')

  """ Fused loki_e """
  info.script.AppendExtra('    ifelse(')
  info.script.AppendExtra('      getprop("ro.hardware") == "loki_e_base" || getprop("ro.hardware") == "loki_e_lte" || getprop("ro.hardware") == "loki_e_wifi",')
  info.script.AppendExtra('      (')
  info.script.AppendExtra('        ifelse(')
  info.script.AppendExtra('          getprop("ro.bootloader") == "' + FOSTER_E_BL_VERSION + '",')
  info.script.AppendExtra('          (')
  info.script.AppendExtra('            ui_print("Correct bootloader already installed for fused " + getprop(ro.hardware));')
  info.script.AppendExtra('          ),')
  info.script.AppendExtra('          ifelse(')
  info.script.AppendExtra('            read_file("' + PUBLIC_KEY_PATH + '") == "' + LOKI_E_PUBLIC_KEY + '",')
  info.script.AppendExtra('            (')
  info.script.AppendExtra('              ui_print("Fused " + getprop(ro.hardware) + " is not currently supported.");')
  info.script.AppendExtra('              ui_print("There has not been a signed bootloader update since rel-24.");')
  info.script.AppendExtra('              ui_print("The newer kernel will not boot on the old bootloader.");')
  info.script.AppendExtra('              abort();')
  info.script.AppendExtra('            ),')
  info.script.AppendExtra('            (')
  info.script.AppendExtra('              ui_print("Unknown public key " + read_file("' + PUBLIC_KEY_PATH + '") + " for " + getprop("ro.hardware") + " detected.");')
  info.script.AppendExtra('              ui_print("This is not supported. Please report to LineageOS Maintainer.");')
  info.script.AppendExtra('              abort();')
  info.script.AppendExtra('            )')
  info.script.AppendExtra('          )')
  info.script.AppendExtra('        );')
  info.script.AppendExtra('        package_extract_file("install/" + tegra_get_dtbname(), "' + DTB_PART + '");')
  info.script.AppendExtra('      )')
  info.script.AppendExtra('    );')

  """ Fused jetson """
  info.script.AppendExtra('    ifelse(')
  info.script.AppendExtra('      getprop("ro.hardware") == "jetson_cv",')
  info.script.AppendExtra('      (')
  info.script.AppendExtra('        ifelse(')
  info.script.AppendExtra('          getprop("ro.bootloader") == "' + FOSTER_E_BL_VERSION + '",')
  info.script.AppendExtra('          (')
  info.script.AppendExtra('            ui_print("Correct bootloader already installed for fused " + getprop(ro.hardware));')
  info.script.AppendExtra('          ),')
  info.script.AppendExtra('          (')
  info.script.AppendExtra('            ui_print("You fused your Jetson TX1?!? Seriously, why would you do this?");')
  info.script.AppendExtra('            ui_print("You are on your own. The LineageOS Maintainer does not want to hear about this.");')
  info.script.AppendExtra('            abort();')
  info.script.AppendExtra('          )')
  info.script.AppendExtra('        );')
  info.script.AppendExtra('        package_extract_file("install/" + tegra_get_dtbname(), "' + DTB_PART + '");')
  info.script.AppendExtra('      )')
  info.script.AppendExtra('    );')

  info.script.AppendExtra('  ),')

  """ If not fused """
  info.script.AppendExtra('  (')

  """ Unfused foster_e or foster_e_hdd """
  info.script.AppendExtra('    ifelse(')
  info.script.AppendExtra('      getprop("ro.hardware") == "foster_e" || getprop("ro.hardware") == "foster_e_hdd",')
  info.script.AppendExtra('      (')
  info.script.AppendExtra('        ifelse(')
  info.script.AppendExtra('          getprop("ro.bootloader") == "' + FOSTER_E_BL_VERSION + '",')
  info.script.AppendExtra('          (')
  info.script.AppendExtra('            ui_print("Correct bootloader already installed for unfused " + getprop(ro.hardware));')
  info.script.AppendExtra('          ),')
  info.script.AppendExtra('          (')
  info.script.AppendExtra('            ui_print("This is an unfused foster_e or foster_e_hdd.");')
  info.script.AppendExtra('            ui_print("This is not supported. Please report to LineageOS Maintainer.");')
  info.script.AppendExtra('            abort();')
  info.script.AppendExtra('          )')
  info.script.AppendExtra('        );')
  info.script.AppendExtra('        package_extract_file("install/" + tegra_get_dtbname(), "' + DTB_PART + '");')
  info.script.AppendExtra('      )')
  info.script.AppendExtra('    );')

  """ Unfused darcy """
  info.script.AppendExtra('    ifelse(')
  info.script.AppendExtra('      getprop("ro.hardware") == "darcy",')
  info.script.AppendExtra('      (')
  info.script.AppendExtra('        ifelse(')
  info.script.AppendExtra('          is_substring("tegra210b01", read_file("' + DTSFILENAME_PATH + '")),')
  """ mdarcy """
  info.script.AppendExtra('          (')
  info.script.AppendExtra('            ui_print("MDarcy is not supported in this build.");')
  info.script.AppendExtra('            abort();')
  info.script.AppendExtra('          ),')
  """ darcy """
  info.script.AppendExtra('          (')
  info.script.AppendExtra('            ifelse(')
  info.script.AppendExtra('              getprop("ro.bootloader") == "' + DARCY_BL_VERSION + '",')
  info.script.AppendExtra('              (')
  info.script.AppendExtra('                ui_print("Correct bootloader already installed for unfused darcy");')
  info.script.AppendExtra('              ),')
  info.script.AppendExtra('              (')
  info.script.AppendExtra('                ui_print("This is an unfused darcy.");')
  info.script.AppendExtra('                ui_print("This is not supported. Please report to LineageOS Maintainer.");')
  info.script.AppendExtra('                abort();')
  info.script.AppendExtra('              )')
  info.script.AppendExtra('            );')
  info.script.AppendExtra('            package_extract_file("install/" + tegra_get_dtbname(), "' + DTB_PART + '");')
  info.script.AppendExtra('          )')
  info.script.AppendExtra('        )')
  info.script.AppendExtra('      )')
  info.script.AppendExtra('    );')

  """ Unfused loki_e """
  info.script.AppendExtra('    ifelse(')
  info.script.AppendExtra('      getprop("ro.hardware") == "loki_e_base" || getprop("ro.hardware") == "loki_e_lte" || getprop("ro.hardware") == "loki_e_wifi",')
  info.script.AppendExtra('      (')
  info.script.AppendExtra('        ifelse(')
  info.script.AppendExtra('          getprop("ro.bootloader") == "' + FOSTER_E_BL_VERSION + '",')
  info.script.AppendExtra('          (')
  info.script.AppendExtra('            ui_print("Correct bootloader already installed for unfused " + getprop(ro.hardware));')
  info.script.AppendExtra('          ),')
  info.script.AppendExtra('          (')
  info.script.AppendExtra('            ui_print("This is an unfused " + getprop(ro.hardware) + ".");')
  info.script.AppendExtra('            ui_print("Updating the bootloader is not currently supported.");')
  info.script.AppendExtra('            ui_print("There has not been a working bootloader since rel-29.");')
  info.script.AppendExtra('            abort();')
  info.script.AppendExtra('          )')
  info.script.AppendExtra('        );')
  info.script.AppendExtra('        package_extract_file("install/" + tegra_get_dtbname(), "' + DTB_PART + '");')
  info.script.AppendExtra('      )')
  info.script.AppendExtra('    );')

  """ Unfused jetson """
  info.script.AppendExtra('    ifelse(')
  info.script.AppendExtra('      getprop("ro.hardware") == "jetson_cv",')
  info.script.AppendExtra('      (')
  info.script.AppendExtra('        ifelse(')
  info.script.AppendExtra('          getprop("ro.bootloader") == "' + FOSTER_E_BL_VERSION + '",')
  info.script.AppendExtra('          (')
  info.script.AppendExtra('            ui_print("Correct bootloader already installed for " + getprop(ro.hardware));')
  info.script.AppendExtra('          ),')
  info.script.AppendExtra('          (')
  info.script.AppendExtra('            ui_print("Flashing updated bootloader for unfused Jetson TX1");')
  info.script.AppendExtra('            package_extract_file("firmware-update/jetson_cv.blob", "' + STAGING_PART + '");')
  info.script.AppendExtra('          )')
  info.script.AppendExtra('        );')
  info.script.AppendExtra('        package_extract_file("install/" + tegra_get_dtbname(), "' + DTB_PART + '");')
  info.script.AppendExtra('      )')
  info.script.AppendExtra('    );')

  info.script.AppendExtra('  )')
  info.script.AppendExtra(');')
