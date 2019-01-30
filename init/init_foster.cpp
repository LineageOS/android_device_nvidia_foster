/*
   Copyright (c) 2013, The Linux Foundation. All rights reserved.
   Redistribution and use in source and binary forms, with or without
   modification, are permitted provided that the following conditions are
   met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above
      copyright notice, this list of conditions and the following
      disclaimer in the documentation and/or other materials provided
      with the distribution.
    * Neither the name of The Linux Foundation nor the names of its
      contributors may be used to endorse or promote products derived
      from this software without specific prior written permission.
   THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED
   WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT
   ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS
   BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
   CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
   SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
   BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
   WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
   OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
   IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#include "init_tegra.h"
#include "service_shield.h"

#include <map>

void set_usb_props(tegra_init *ti)
{
	std::map<std::string, std::string> mcommon       = { { "ro.nv.usb.vid",                  "0955" },
	                                                     { "ro.nv.usb.pid.rndis.acm.adb",    "AF00" },
	                                                     { "ro.nv.usb.pid.adb",              "7104" },
	                                                     { "ro.nv.usb.pid.accessory.adb",    "7105" },
	                                                     { "ro.nv.usb.pid.audio_source.adb", "7106" },
	                                                     { "ro.nv.usb.pid.ncm",              "7107" },
	                                                     { "ro.nv.usb.pid.ncm.adb",          "7108" },
	                                                     { "ro.nv.usb.pid.ecm",              "710B" },
	                                                     { "ro.nv.usb.pid.ecm.adb",          "710C" },
	                                                     { "ro.nv.usb.pid.midi",             "7109" },
	                                                     { "ro.nv.usb.pid.midi.adb",         "710A" } };

	std::map<std::string, std::string> mfoster_e     = { { "ro.nv.usb.pid.mtp",              "B430" },
	                                                     { "ro.nv.usb.pid.mtp.adb",          "B431" },
	                                                     { "ro.nv.usb.pid.rndis",            "B434" },
	                                                     { "ro.nv.usb.pid.rndis.adb",        "B435" },
	                                                     { "ro.nv.usb.pid.ptp",              "B432" },
	                                                     { "ro.nv.usb.pid.ptp.adb",          "B433" } };

	std::map<std::string, std::string> mfoster_e_hdd = { { "ro.nv.usb.pid.mtp",              "B436" },
	                                                     { "ro.nv.usb.pid.mtp.adb",          "B437" },
	                                                     { "ro.nv.usb.pid.rndis",            "B43A" },
	                                                     { "ro.nv.usb.pid.rndis.adb",        "B43B" },
	                                                     { "ro.nv.usb.pid.ptp",              "B43E" },
	                                                     { "ro.nv.usb.pid.ptp.adb",          "B43F" } };

	std::map<std::string, std::string> mdarcy        = { { "ro.nv.usb.pid.mtp",              "B43C" },
	                                                     { "ro.nv.usb.pid.mtp.adb",          "B43D" },
	                                                     { "ro.nv.usb.pid.rndis",            "B440" },
	                                                     { "ro.nv.usb.pid.rndis.adb",        "B441" },
	                                                     { "ro.nv.usb.pid.ptp",              "B43E" },
	                                                     { "ro.nv.usb.pid.ptp.adb",          "B43F" } };

	std::map<std::string, std::string> mloki_e       = { { "ro.nv.usb.pid.mtp",              "B424" },
	                                                     { "ro.nv.usb.pid.mtp.adb",          "B425" },
	                                                     { "ro.nv.usb.pid.rndis",            "B428" },
	                                                     { "ro.nv.usb.pid.rndis.adb",        "B429" },
	                                                     { "ro.nv.usb.pid.ptp",              "B426" },
	                                                     { "ro.nv.usb.pid.ptp.adb",          "B427" } };

	std::map<std::string, std::string> mt210ref      = { { "ro.nv.usb.pid.mtp",              "EE02" },
	                                                     { "ro.nv.usb.pid.mtp.adb",          "EE03" },
	                                                     { "ro.nv.usb.pid.rndis",            "EE08" },
	                                                     { "ro.nv.usb.pid.rndis.adb",        "EE09" },
	                                                     { "ro.nv.usb.pid.ptp",              "EE04" },
	                                                     { "ro.nv.usb.pid.ptp.adb",          "EE05" } };

	for (auto const& nvusb : mcommon)
		ti->property_set(nvusb.first, nvusb.second);

	if (ti->is_model("foster_e")) {
		for (auto const& nvusb : mfoster_e)
			ti->property_set(nvusb.first, nvusb.second);
	} else if (ti->is_model("foster_e_hdd")) {
		for (auto const& nvusb : mfoster_e_hdd)
			ti->property_set(nvusb.first, nvusb.second);
	} else if (ti->is_model("darcy") || ti->is_model("sif")) {
		for (auto const& nvusb : mdarcy)
			ti->property_set(nvusb.first, nvusb.second);
	} else if (ti->is_model("loki_e_base") || ti->is_model("loki_e_lte") || ti->is_model("loki_e_wifi")) {
		for (auto const& nvusb : mloki_e)
			ti->property_set(nvusb.first, nvusb.second);
	} else {
		for (auto const& nvusb : mt210ref)
			ti->property_set(nvusb.first, nvusb.second);
	}
}

void vendor_load_properties()
{
	//                                              device    name            model               id    sku   boot device type                api  dpi
	std::vector<tegra_init::devices> devices = { { "foster", "foster_e",     "SHIELD Android TV", 2530,  930, tegra_init::boot_dev_type::EMMC, 21, 320 },
	                                             { "foster", "foster_e_hdd", "SHIELD Android TV", 2530,  932, tegra_init::boot_dev_type::SATA, 21, 320 },
	                                             { "darcy",  "darcy",        "SHIELD Android TV", 2894,   52, tegra_init::boot_dev_type::EMMC, 23, 320 },
	                                             { "sif",    "sif",          "SHIELD Android TV", 3425,  500, tegra_init::boot_dev_type::EMMC, 23, 320 },
	                                             { "loki",   "loki_e_base",  "SHIELD Portable",   2530,  131, tegra_init::boot_dev_type::EMMC, 21, 216 },
	                                             { "loki",   "loki_e_lte",   "SHIELD Portable",   2530,   31, tegra_init::boot_dev_type::EMMC, 21, 240 },
	                                             { "loki",   "loki_e_wifi",  "SHIELD Portable",   2530,   30, tegra_init::boot_dev_type::EMMC, 21, 240 },
	                                             { "jetson", "jetson_cv",    "Jetson TX1",        2597, 2180, tegra_init::boot_dev_type::EMMC, 21, 320 },
	                                             { "jetson", "jetson_e",     "Jetson TX1",        2595,    0, tegra_init::boot_dev_type::EMMC, 21, 320 },
	                                             { "porg",   "porg",         "Jetson Nano",       3448,    0, tegra_init::boot_dev_type::SD,   23, 320 },
	                                             { "porg",   "porg",         "Jetson Nano",       3448,    2, tegra_init::boot_dev_type::EMMC, 23, 320 } };
	tegra_init::build_version sav = { "8.0.0", "OPR6.170623.010", "3507953_1441.7411" };
	std::vector<std::string> parts = { "APP", "CAC", "LNX", "MSC", "UDA", "USP", "MDA", "SOS", "BMP", "vendor" };

	tegra_init ti(devices);
	ti.set_properties();
	ti.set_fingerprints(sav);
	ti.recovery_links(parts);

	set_usb_props(&ti);
}

int vendor_handle_control_message(const std::string &msg, const std::string &arg)
{
    return shield_handle_control_message(msg, arg);
}
