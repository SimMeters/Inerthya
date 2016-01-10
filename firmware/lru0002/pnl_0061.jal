------------------------------------------------------------------------------------------------------------------------
-- Copyright (c) 2015, SimMeters.
-- All rights reserved. Released under the BSD license.
-- pnl_0061.jal 1.0 01/01/2015 (Annunciators Panel MP project)

-- Redistribution and use in source and binary forms, with or without modification, are permitted provided that the
-- following conditions are met:

-- 1. Redistributions of source code must retain the above copyright notice, this list of conditions and the
-- following disclaimer.

-- 2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the
-- following disclaimer in the documentation and/or other materials provided with the distribution.

-- THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
-- INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
-- DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
-- SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
-- SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
-- WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
-- USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
------------------------------------------------------------------------------------------------------------------------
include atachapters
include canaerospace
include lru0002
include canbus
include objects

------------------------------------------------------------------------------------------------------------------------
-- Variables Declaration
------------------------------------------------------------------------------------------------------------------------
var can_frame cf
var dword lamps_0_31

------------------------------------------------------------------------------------------------------------------------
-- Initialization
------------------------------------------------------------------------------------------------------------------------
_usec_delay(1000000)

setup_can_init()
add_can_rxfilter(id_request_bootloader)
add_can_rxfilter(id_lamps_0_31)
setup_can_end()

set_pin(p21, low)
set_pin(p22, high)

------------------------------------------------------------------------------------------------------------------------
-- Objects Definition
------------------------------------------------------------------------------------------------------------------------
var volatile lamp lp00 = new_lamp(p05, mask_lamp_01) -- STARTER
var volatile lamp lp01 = new_lamp(p06, mask_lamp_02) -- GOV. OFF
var volatile lamp lp02 = new_lamp(p07, mask_lamp_03) -- BRAKE
var volatile lamp lp03 = new_lamp(p08, mask_lamp_04) -- OIL PRESSURE
var volatile lamp lp04 = new_lamp(p09, mask_lamp_05) -- GEARBOX TEMP
var volatile lamp lp05 = new_lamp(p10, mask_lamp_06) -- LOW FUEL
var volatile lamp lp06 = new_lamp(p11, mask_lamp_07) -- ALTERNATOR
var volatile lamp lp07 = new_lamp(p12, mask_lamp_08) -- HIGH RPM
var volatile lamp lp08 = new_lamp(p14, mask_lamp_09) -- UNK
var volatile lamp lp09 = new_lamp(p15, mask_lamp_10) -- LOW RPM
var volatile lamp lp10 = new_lamp(p16, mask_lamp_11) -- CLUTCH

------------------------------------------------------------------------------------------------------------------------
-- Main Loop
------------------------------------------------------------------------------------------------------------------------
forever loop

    request_bootloader("pnl_0061")

    -- process objects
    cf = get_can_frame(id_lamps_0_31)
    if(cf.dlc > 0) then

        lamps_0_31 = get_can_uint32(cf)
        process_lamp(lp00, lamps_0_31)
        process_lamp(lp01, lamps_0_31)
        process_lamp(lp02, lamps_0_31)
        process_lamp(lp03, lamps_0_31)
        process_lamp(lp04, lamps_0_31)
        process_lamp(lp05, lamps_0_31)
        process_lamp(lp06, lamps_0_31)
        process_lamp(lp07, lamps_0_31)
        process_lamp(lp08, lamps_0_31)
        process_lamp(lp09, lamps_0_31)
        process_lamp(lp10, lamps_0_31)

    end if

end loop