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

#include <map>

void vendor_set_usb_product_ids(tegra_init *ti)
{
	std::map<std::string, std::string> mCommonUsbIds, mDeviceUsbIds;

	mCommonUsbIds["ro.vendor.nv.usb.vid"]                  = "0955";
	mCommonUsbIds["ro.vendor.nv.usb.pid.rndis.acm.adb"]    = "AF00";
	mCommonUsbIds["ro.vendor.nv.usb.pid.adb"]              = "7104";
	mCommonUsbIds["ro.vendor.nv.usb.pid.accessory.adb"]    = "7105";
	mCommonUsbIds["ro.vendor.nv.usb.pid.audio_source.adb"] = "7106";
	mCommonUsbIds["ro.vendor.nv.usb.pid.ncm"]              = "7107";
	mCommonUsbIds["ro.vendor.nv.usb.pid.ncm.adb"]          = "7108";
	mCommonUsbIds["ro.vendor.nv.usb.pid.midi"]             = "7109";
	mCommonUsbIds["ro.vendor.nv.usb.pid.midi.adb"]         = "710A";
	mCommonUsbIds["ro.vendor.nv.usb.pid.ecm"]              = "710B";
	mCommonUsbIds["ro.vendor.nv.usb.pid.ecm.adb"]          = "710C";

	if (ti->is_model("foster_e")) {
		mDeviceUsbIds["ro.vendor.nv.usb.pid.mtp"]       = "B430";
		mDeviceUsbIds["ro.vendor.nv.usb.pid.mtp.adb"]   = "B431";
		mDeviceUsbIds["ro.vendor.nv.usb.pid.ptp"]       = "B432";
		mDeviceUsbIds["ro.vendor.nv.usb.pid.ptp.adb"]   = "B433";
		mDeviceUsbIds["ro.vendor.nv.usb.pid.rndis"]     = "B434";
		mDeviceUsbIds["ro.vendor.nv.usb.pid.rndis.adb"] = "B435";
	} else if (ti->is_model("foster_e_hdd")) {
		mDeviceUsbIds["ro.vendor.nv.usb.pid.mtp"]       = "B436";
		mDeviceUsbIds["ro.vendor.nv.usb.pid.mtp.adb"]   = "B437";
		mDeviceUsbIds["ro.vendor.nv.usb.pid.ptp"]       = "B43E";
		mDeviceUsbIds["ro.vendor.nv.usb.pid.ptp.adb"]   = "B43F";
		mDeviceUsbIds["ro.vendor.nv.usb.pid.rndis"]     = "B43A";
		mDeviceUsbIds["ro.vendor.nv.usb.pid.rndis.adb"] = "B43B";
	} else if (ti->is_model("darcy") || ti->is_model("sif")) {
		mDeviceUsbIds["ro.vendor.nv.usb.pid.mtp"]       = "B43C";
		mDeviceUsbIds["ro.vendor.nv.usb.pid.mtp.adb"]   = "B43D";
		mDeviceUsbIds["ro.vendor.nv.usb.pid.ptp"]       = "B43E";
		mDeviceUsbIds["ro.vendor.nv.usb.pid.ptp.adb"]   = "B43F";
		mDeviceUsbIds["ro.vendor.nv.usb.pid.rndis"]     = "B440";
		mDeviceUsbIds["ro.vendor.nv.usb.pid.rndis.adb"] = "B441";
	} else if (ti->is_model("mdarcy")) {
		mDeviceUsbIds["ro.vendor.nv.usb.pid.mtp"]       = "B42A";
		mDeviceUsbIds["ro.vendor.nv.usb.pid.mtp.adb"]   = "B42B";
		mDeviceUsbIds["ro.vendor.nv.usb.pid.ptp"]       = "B42C";
		mDeviceUsbIds["ro.vendor.nv.usb.pid.ptp.adb"]   = "B42D";
		mDeviceUsbIds["ro.vendor.nv.usb.pid.rndis"]     = "B42E";
		mDeviceUsbIds["ro.vendor.nv.usb.pid.rndis.adb"] = "B42F";
	} else if (ti->is_model("loki_e_base") || ti->is_model("loki_e_lte") || ti->is_model("loki_e_wifi")) {
		mDeviceUsbIds["ro.vendor.nv.usb.pid.mtp"]       = "B424";
		mDeviceUsbIds["ro.vendor.nv.usb.pid.mtp.adb"]   = "B425";
		mDeviceUsbIds["ro.vendor.nv.usb.pid.ptp"]       = "B426";
		mDeviceUsbIds["ro.vendor.nv.usb.pid.ptp.adb"]   = "B427";
		mDeviceUsbIds["ro.vendor.nv.usb.pid.rndis"]     = "B428";
		mDeviceUsbIds["ro.vendor.nv.usb.pid.rndis.adb"] = "B429";
	} else if (ti->is_model("icosa") || ti->is_model("icosa_emmc")) {
		mDeviceUsbIds["ro.vendor.nv.usb.vid"]           = "057E";
		mDeviceUsbIds["ro.vendor.nv.usb.pid.mtp"]       = "2000";
		mDeviceUsbIds["ro.vendor.nv.usb.pid.mtp.adb"]   = "2000";
		mDeviceUsbIds["ro.vendor.nv.usb.pid.ptp"]       = "2000";
		mDeviceUsbIds["ro.vendor.nv.usb.pid.ptp.adb"]   = "2000";
		mDeviceUsbIds["ro.vendor.nv.usb.pid.rndis"]     = "2000";
		mDeviceUsbIds["ro.vendor.nv.usb.pid.rndis.adb"] = "2000";
	} else if (ti->is_model("dragon")) {
		mDeviceUsbIds["ro.vendor.nv.usb.vid"]                  = "18D1";
		mDeviceUsbIds["ro.vendor.nv.usb.pid.mtp"]              = "5202";
		mDeviceUsbIds["ro.vendor.nv.usb.pid.mtp.adb"]          = "5203";
		mDeviceUsbIds["ro.vendor.nv.usb.pid.ptp"]              = "5206";
		mDeviceUsbIds["ro.vendor.nv.usb.pid.ptp.adb"]          = "5207";
		mDeviceUsbIds["ro.vendor.nv.usb.pid.rndis"]            = "5204";
		mDeviceUsbIds["ro.vendor.nv.usb.pid.rndis.adb"]        = "5205";
		mCommonUsbIds["ro.vendor.nv.usb.pid.adb"]              = "5208";
		mCommonUsbIds["ro.vendor.nv.usb.pid.accessory.adb"]    = "2D01";
		mCommonUsbIds["ro.vendor.nv.usb.pid.audio_source.adb"] = "2D03";
		mCommonUsbIds["ro.vendor.nv.usb.pid.midi"]             = "5209";
		mCommonUsbIds["ro.vendor.nv.usb.pid.midi.adb"]         = "520A";

	} else {
		mDeviceUsbIds["ro.vendor.nv.usb.pid.mtp"]       = "EE02";
		mDeviceUsbIds["ro.vendor.nv.usb.pid.mtp.adb"]   = "EE03";
		mDeviceUsbIds["ro.vendor.nv.usb.pid.ptp"]       = "EE04";
		mDeviceUsbIds["ro.vendor.nv.usb.pid.ptp.adb"]   = "EE05";
		mDeviceUsbIds["ro.vendor.nv.usb.pid.rndis"]     = "EE08";
		mDeviceUsbIds["ro.vendor.nv.usb.pid.rndis.adb"] = "EE09";
	}

	for (auto const& id : mDeviceUsbIds)
		ti->property_set(id.first, id.second);

	for (auto const& id : mCommonUsbIds)
		ti->property_set(id.first, id.second);
}

void vendor_load_properties()
{
	//                                              device    name            model               id    sku   boot device type                api  dpi
	std::vector<tegra_init::devices> devices = { { "foster", "foster_e",     "SHIELD Android TV", 2530,  930, tegra_init::boot_dev_type::EMMC, 21, 320 },
	                                             { "foster", "foster_e_hdd", "SHIELD Android TV", 2530,  932, tegra_init::boot_dev_type::SATA, 21, 320 },
	                                             { "darcy",  "darcy",        "SHIELD Android TV", 2894,   52, tegra_init::boot_dev_type::EMMC, 23, 320 },
	                                             { "mdarcy", "mdarcy",       "SHIELD Android TV", 2894, 2551, tegra_init::boot_dev_type::EMMC, 28, 320 },
	                                             { "sif",    "sif",          "SHIELD Android TV", 3425,  500, tegra_init::boot_dev_type::EMMC, 28, 320 },
	                                             { "loki",   "loki_e_base",  "SHIELD Portable",   2530,  131, tegra_init::boot_dev_type::EMMC, 21, 192 },
	                                             { "loki",   "loki_e_lte",   "SHIELD Portable",   2530,   31, tegra_init::boot_dev_type::EMMC, 21, 240 },
	                                             { "loki",   "loki_e_wifi",  "SHIELD Portable",   2530,   30, tegra_init::boot_dev_type::EMMC, 21, 240 },
	                                             { "jetson", "jetson_cv",    "Jetson TX1",        2597, 2180, tegra_init::boot_dev_type::EMMC, 21, 320 },
	                                             { "jetson", "jetson_e",     "Jetson TX1",        2595,    0, tegra_init::boot_dev_type::EMMC, 21, 320 },
	                                             { "porg",   "porg_sd",      "Jetson Nano",       3448,    0, tegra_init::boot_dev_type::SD,   28, 320 },
	                                             { "porg",   "porg",         "Jetson Nano",       3448,    2, tegra_init::boot_dev_type::EMMC, 28, 320 },
	                                             { "icosa",  "icosa_emmc",   "Switch",              20,    1, tegra_init::boot_dev_type::EMMC, 27, 192 },
	                                             { "icosa",  "icosa",        "Switch",              20,    0, tegra_init::boot_dev_type::SD,   27, 192 },
	                                             { "dragon", "dragon",       "Pixel C",              3,    0, tegra_init::boot_dev_type::EMMC, 23, 320 } };
	tegra_init::build_version tav = { "9", "PPR1.180610.011", "4199485_1739.5219" };
	std::vector<std::string> parts = { "APP", "CAC", "LNX", "SOS", "UDA", "USP", "vendor" };

	tegra_init ti(devices);

	if (ti.is_model("foster_e") || ti.is_model("foster_e_hdd") || ti.is_model("darcy")) {
		tav.nvidia_version = "4086637_1873.3004";

		if (ti.vendor_context()) {
			ti.property_set("ro.product.vendor.device", "t210");
			ti.property_set("ro.product.vendor.model", ti.get_model());
		}
	} else if (ti.is_model("icosa") || ti.is_model("icosa_emmc")) {
		parts.erase(std::remove(parts.begin(), parts.end(), "USP"), parts.end()); 
	} else if (ti.is_model("dragon")) {
		tav = { "8.1.0", "OPM8.190605.005", "5749003" };
		ti.property_set("ro.product.name", "ryu");

		if (ti.recovery_context()) {
			std::map<std::string,std::string> dragon_parts;
			dragon_parts.emplace("KERN-A", "LNX");
			dragon_parts.emplace("recovery", "SOS");
			dragon_parts.emplace("VNR", "vendor");
			ti.recovery_links(dragon_parts);

			parts.erase(std::remove(parts.begin(), parts.end(), "LNX"), parts.end()); 
			parts.erase(std::remove(parts.begin(), parts.end(), "SOS"), parts.end()); 
			parts.erase(std::remove(parts.begin(), parts.end(), "USP"), parts.end()); 
			parts.erase(std::remove(parts.begin(), parts.end(), "vendor"), parts.end());
		} else if (ti.vendor_context()) {
			ti.property_set("ro.product.vendor.name", "ryu");
		}
	}

	ti.set_properties();
	ti.set_fingerprints(tav);

	if (ti.recovery_context()) {
		ti.recovery_links(parts);
		ti.property_set("ro.product.vendor.model", ti.property_get("ro.product.model"));
		ti.property_set("ro.product.vendor.manufacturer", ti.property_get("ro.product.manufacturer"));

		// Unset avb flags. This is to ignore compatibility checks on unified builds
		if (ti.is_model("mdarcy") || ti.is_model("sif"))
			ti.property_set("ro.boot.avb_version", "");
	}

	if (ti.vendor_context() || ti.recovery_context())
		vendor_set_usb_product_ids(&ti);
}
