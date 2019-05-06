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

if [ "$(getprop ro.hardware)" == "darcy" -o "$(getprop ro.hardware)" == "sif" ]; then
  rm "/vendor/app/eks2/eks2.dat"
  rm "/vendor/app/eks2/eks2_public.dat"
  mv "/vendor/app/eks2/eks2_darcy.dat" "/vendor/app/eks2/eks2.dat"
elif [ "$(getprop ro.hardware)" == "jetson_cv" -o "$(getprop ro.hardware)" == "jetson_e" ]; then
  rm "/vendor/app/eks2/eks2.dat"
  rm "/vendor/app/eks2/eks2_darcy.dat"
  rm "/vendor/app/eks2/eks2_mdarcy.dat"
  mv "/vendor/app/eks2/eks2_public.dat" "/vendor/app/eks2/eks2.dat"
else
  rm "/vendor/app/eks2/eks2_darcy.dat"
  rm "/vendor/app/eks2/eks2_mdarcy.dat"
  rm "/vendor/app/eks2/eks2_public.dat"
fi;
