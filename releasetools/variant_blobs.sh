#!/sbin/sh
#
# Copyright (C) 2017 The LineageOS Project
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

LD_LIBRARY_PATH=/system/lib64

# If variant blobs not available, likely due to using extract scripts, this isn't needed.
if [ ! -f "/system/vendor/lib/liboemcrypto.darcy.so" ]; then
  exit 0;
fi;

if [ "$(getprop ro.hardware)" == "loki_e_wifi" -o "$(getprop ro.hardware)" == "loki_e_lte" ]; then
  /system/bin/toybox rm "/system/vendor/app/eks2/eks2_darcy.dat"
  /system/bin/toybox rm "/system/vendor/lib/liboemcrypto.so"
  /system/bin/toybox rm "/system/vendor/lib/liboemcrypto.darcy.so"
  /system/bin/toybox mv "/system/vendor/lib/liboemcrypto.loki.so" "/system/vendor/lib/liboemcrypto.so"
elif [ "$(getprop ro.hardware)" == "darcy" ]; then
  /system/bin/toybox rm "/system/vendor/app/eks2/eks2.dat"
  /system/bin/toybox mv "/system/vendor/app/eks2/eks2_darcy.dat" "/system/vendor/app/eks2/eks2.dat"
  /system/bin/toybox rm "/system/vendor/lib/liboemcrypto.so"
  /system/bin/toybox rm "/system/vendor/lib/liboemcrypto.loki.so"
  /system/bin/toybox mv "/system/vendor/lib/liboemcrypto.darcy.so" "/system/vendor/lib/liboemcrypto.so"
  /system/bin/toybox rm -rf "/system/vendor/app/ConsoleUI"
  /system/bin/toybox sed -i 's/AUDIO_DEVICE_IN_BUILTIN_MIC|//' "/system/etc/audio_policy.conf"
  /system/bin/toybox sed -i 's/builtin speaker" val="1"/builtin speaker" val="0"/' "/system/etc/nvaudio_conf.xml"
else
  /system/bin/toybox rm "/system/vendor/app/eks2/eks2_darcy.dat"
  /system/bin/toybox rm "/system/vendor/lib/liboemcrypto.darcy.so"
  /system/bin/toybox rm "/system/vendor/lib/liboemcrypto.loki.so"
  /system/bin/toybox rm -rf "/system/vendor/app/ConsoleUI"
  /system/bin/toybox sed -i 's/AUDIO_DEVICE_IN_BUILTIN_MIC|//' "/system/etc/audio_policy.conf"
  /system/bin/toybox sed -i 's/builtin speaker" val="1"/builtin speaker" val="0"/' "/system/etc/nvaudio_conf.xml"
fi;
