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

#include <stdlib.h>

#include "vendor_init.h"
#include "property_service.h"
#include "log.h"
#include "util.h"
#include <stdio.h>
#include <string.h>

void vendor_load_properties()
{
    char platform[PROP_VALUE_MAX];
    char model[PROP_VALUE_MAX];
    char devicename[PROP_VALUE_MAX];
    int rc;
    FILE  *fp = NULL;
    char  *board_info = NULL;
    size_t len = 0;
    size_t read;

    rc = property_get("ro.board.platform", platform);
    if (!rc || strncmp(platform, ANDROID_TARGET, PROP_VALUE_MAX))
        return;

    // Get model from /proc/cmdline
    fp = fopen("/proc/cmdline", "r");
    if (fp == NULL)
         return;
    while ((read = getline(&board_info, &len, fp)) != (size_t)-1) {
        if (strstr(board_info, "board_info"))
            break;
    }
    fclose(fp);

    if (strstr(board_info, "0x00ea")) {
        /* EMMC Model */
        property_set("ro.build.fingerprint", "nvidia/foster_e/t210:5.0./LRX21M/29979_515.3274:user/release-keys");
        property_set("ro.build.description", "foster_e-user 5.0 LRX21M 29979_515.3274 release-keys");
        property_set("ro.product.model", "foster_e");
    } else if (strstr(board_info, "0x04d2")) {
        /* SATA Model */
        property_set("ro.build.fingerprint", "nvidia/foster_e_hdd/t210:5.0./LRX21M/29979_515.3274:user/release-keys");
        property_set("ro.build.description", "foster_e_hdd-user 5.0 LRX21M 29979_515.3274 release-keys");
        property_set("ro.product.model", "foster_e_hdd");
    }

    if (board_info)
        free(board_info);

    property_set("ro.product.device", "foster");
    property_get("ro.product.model", model);
    ERROR("Setting build properties for %s model\n", model);
}
