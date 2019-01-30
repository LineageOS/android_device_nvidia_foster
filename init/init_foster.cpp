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

void vendor_load_properties()
{
	//                                              device    name            model               id    sku   boot device type                api  dpi
	std::vector<tegra_init::devices> devices = { { "foster", "foster_e",     "SHIELD Android TV", 2530,  930, tegra_init::boot_dev_type::EMMC, 21, 320 },
	                                             { "foster", "foster_e_hdd", "SHIELD Android TV", 2530,  932, tegra_init::boot_dev_type::SATA, 21, 320 },
	                                             { "darcy",  "darcy",        "SHIELD Android TV", 2894,   52, tegra_init::boot_dev_type::EMMC, 23, 320 },
	                                             { "sif",    "sif",          "SHIELD Android TV", 3425,  500, tegra_init::boot_dev_type::EMMC, 23, 320 },
	                                             { "jetson", "jetson_cv",    "Jetson TX1",        2597, 2180, tegra_init::boot_dev_type::EMMC, 21, 320 },
	                                             { "jetson", "jetson_e",     "Jetson TX1",        2595,    0, tegra_init::boot_dev_type::EMMC, 21, 320 },
	                                             { "loki",   "loki_e_base",  "SHIELD Portable",   2530,  131, tegra_init::boot_dev_type::EMMC, 21, 216 },
	                                             { "loki",   "loki_e_lte",   "SHIELD Portable",   2530,   31, tegra_init::boot_dev_type::EMMC, 21, 240 },
	                                             { "loki",   "loki_e_wifi",  "SHIELD Portable",   2530,   30, tegra_init::boot_dev_type::EMMC, 21, 240 } };
	tegra_init::build_version sav = { "8.0.0", "OPR6.170623.010", "3507953_1441.7411" };
	std::vector<std::string> parts = { "APP", "CAC", "LNX", "MSC", "UDA", "USP", "MDA", "SOS", "BMP", "vendor" };

	tegra_init ti(devices);
	ti.set_properties();
	ti.set_fingerprints(sav);
	ti.recovery_links(parts);
}

int vendor_handle_control_message(const std::string &msg, const std::string &arg)
{
    return shield_handle_control_message(msg, arg);
}
