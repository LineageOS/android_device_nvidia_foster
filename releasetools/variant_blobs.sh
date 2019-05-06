#!/sbin/sh
#
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

LD_LIBRARY_PATH=/vendor/lib64

if ! [ "$(getprop ro.hardware)" == "loki_e_wifi" -o "$(getprop ro.hardware)" == "loki_e_lte" -o "$(getprop ro.hardware)" == "loki_e_base" ]; then
  /vendor/bin/toybox_vendor rm -rf "/vendor/app/ConsoleUI"
fi;

if [ "$(getprop ro.hardware)" == "darcy" -o "$(getprop ro.hardware)" == "sif" ]; then
  /vendor/bin/toybox_vendor rm "/vendor/app/eks2/eks2.dat"
  /vendor/bin/toybox_vendor rm "/vendor/app/eks2/eks2_public.dat"
  /vendor/bin/toybox_vendor mv "/vendor/app/eks2/eks2_darcy.dat" "/vendor/app/eks2/eks2.dat"
elif [ "$(getprop ro.hardware)" == "jetson_cv" -o "$(getprop ro.hardware)" == "jetson_e" ]; then
  /vendor/bin/toybox_vendor rm "/vendor/app/eks2/eks2.dat"
  /vendor/bin/toybox_vendor rm "/vendor/app/eks2/eks2_darcy.dat"
  /vendor/bin/toybox_vendor rm "/vendor/app/eks2/eks2_mdarcy.dat"
  /vendor/bin/toybox_vendor mv "/vendor/app/eks2/eks2_public.dat" "/vendor/app/eks2/eks2.dat"
else
  /vendor/bin/toybox_vendor rm "/vendor/app/eks2/eks2_darcy.dat"
  /vendor/bin/toybox_vendor rm "/vendor/app/eks2/eks2_mdarcy.dat"
  /vendor/bin/toybox_vendor rm "/vendor/app/eks2/eks2_public.dat"
fi;
