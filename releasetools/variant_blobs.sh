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

if [ "$(getprop ro.hardware)" == "loki_e_wifi" ]; then
  /system/bin/toybox rm "/system/vendor/lib/liboemcrypto.so"
  /system/bin/toybox mv "/system/vendor/lib/liboemcrypto.loki.so" "/system/vendor/lib/liboemcrypto.so"
else
  /system/bin/toybox rm "/system/vendor/lib/liboemcrypto.loki.so"
  /system/bin/toybox rm -rf "/system/vendor/app/ConsoleUI"
fi;
