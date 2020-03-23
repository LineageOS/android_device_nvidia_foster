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

TARGET_DIR = os.getenv('OUT')
STAGING_PART = '/dev/block/USP'
APP_PART = '/dev/block/APP'
VENDOR_PART = '/dev/block/vendor'
ICOSA_SD = '/external_sd/switchroot/android/'

def FullOTA_PostValidate(info):
  info.script.AppendExtra('run_program("/sbin/e2fsck", "-fy", "' + APP_PART + '");');
  info.script.AppendExtra('run_program("/sbin/e2fsck", "-fy", "' + VENDOR_PART + '");');
  info.script.AppendExtra('run_program("/sbin/resize2fs", "' + APP_PART + '");');
  info.script.AppendExtra('run_program("/sbin/resize2fs", "' + VENDOR_PART + '");');
  info.script.AppendExtra('run_program("/sbin/e2fsck", "-fy", "' + APP_PART + '");');
  info.script.AppendExtra('run_program("/sbin/e2fsck", "-fy", "' + VENDOR_PART + '");');

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
  android_info = input_zip.read("OTA/android-info.txt").decode('utf-8')
  m = re.search(r"require\s+version-bootloader\s*=\s*(\S+)", android_info)
  if m:
    bootloaders = m.group(1).split("|")
    info.metadata["pre-bootloader"] = m.group(1)
    if "*" not in bootloaders:
      info.script.AppendExtra('ifelse(')
      info.script.AppendExtra('  getprop("ro.hardware") == "foster_e" || getprop("ro.hardware") == "foster_e_hdd" || getprop("ro.hardware") == "darcy" || getprop("ro.hardware") == "icosa",')
      info.script.AppendExtra('  ifelse(')
      info.script.AppendExtra('    ' + ' || '.join(['getprop("ro.bootloader") == "%s"' % (b,) for b in bootloaders]) + ',')
      info.script.AppendExtra('    (')
      info.script.AppendExtra('      ui_print("Correct bootloader already installed");')
      info.script.AppendExtra('    ),')
      info.script.AppendExtra('    (')
      info.script.AppendExtra('      ui_print("Flashing updated bootloader");')
      info.script.AppendExtra('      ifelse(')
      info.script.AppendExtra('        getprop("ro.hardware") == "icosa",')
      info.script.AppendExtra('        (')
      info.script.AppendExtra('          package_extract_file("firmware-update/coreboot.rom", "' + ICOSA_SD + 'coreboot.rom");')
      info.script.AppendExtra('          package_extract_file("firmware-update/boot.scr", "' + ICOSA_SD + 'boot.scr");')
      info.script.AppendExtra('        ),')
      info.script.AppendExtra('        package_extract_file("firmware-update/" + getprop(ro.hardware) + ".blob", "' + STAGING_PART + '");')
      info.script.AppendExtra('      )')
      info.script.AppendExtra('    )')
      info.script.AppendExtra('  ),')
      info.script.AppendExtra('  assert(' + ' || '.join(['getprop("ro.bootloader") == "%s"' % (b,) for b in bootloaders]) +
                                 ' || abort("This package supports bootloader(s): ' + ', '.join(["%s" % (b,) for b in bootloaders]) +
                                 '; this device has bootloader " + getprop("ro.bootloader") + ".");' + ');')
      info.script.AppendExtra(');')
