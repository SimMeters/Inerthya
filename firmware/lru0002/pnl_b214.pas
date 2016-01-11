------------------------------------------------------------------------------------------------------------------------
-- Copyright (c) 2015, SimMeters.
-- All rights reserved. Released under the BSD license.
-- pnl_b214.jal 1.0 01/01/2015 (Caution Panel Lights Section UH-1D project)

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
var dword id_lamps_0_31

------------------------------------------------------------------------------------------------------------------------
-- Initialization
------------------------------------------------------------------------------------------------------------------------
_usec_delay(1000000)

setup_can_init()
add_can_rxfilter(id_request_bootloader)
add_can_rxfilter(id_id_lamps_0_31)
setup_can_end()

set_pin(P21, low)
set_pin(P22, high)

------------------------------------------------------------------------------------------------------------------------
-- Objects Definition
------------------------------------------------------------------------------------------------------------------------
var volatile lamp lp00 = new_lamp(p05, mask_lamp_04) -- ENGINE_OIL_PRESS
var volatile lamp lp01 = new_lamp(p06, mask_lamp_05) -- ENGINE_ICING
var volatile lamp lp02 = new_lamp(p07, mask_lamp_06) -- ENGINE_ICE_DET
var volatile lamp lp03 = new_lamp(p08, mask_lamp_07) -- ENGINE_CHIP_DET
var volatile lamp lp04 = new_lamp(p09, mask_lamp_08) -- LEFT_FUEL_BOOST
var volatile lamp lp05 = new_lamp(p10, mask_lamp_09) -- ENG_FUEL_PUMP
var volatile lamp lp06 = new_lamp(p11, mask_lamp_10) -- RIGHT_FUEL_BOOST
var volatile lamp lp07 = new_lamp(p12, mask_lamp_11) -- 20_MINUTE_FUEL
var volatile lamp lp08 = new_lamp(P14, mask_lamp_12) -- FUEL_FILTER
var volatile lamp lp09 = new_lamp(p15, mask_lamp_13) -- GOV_EMERG
var volatile lamp lp10 = new_lamp(p16, mask_lamp_14) -- AUX_FUEL_LOW
var volatile lamp lp11 = new_lamp(p17, mask_lamp_15) -- XMSN_OIL_PRESS
var volatile lamp lp12 = new_lamp(p18, mask_lamp_16) -- XMSN_OIL_HOT
var volatile lamp lp13 = new_lamp(p26, mask_lamp_17) -- HYD_PRESSURE
var volatile lamp lp14 = new_lamp(p27, mask_lamp_18) -- ENGINE_INLET_AIR
var volatile lamp lp15 = new_lamp(p28, mask_lamp_19) -- INST_INVERTER
var volatile lamp lp16 = new_lamp(p32, mask_lamp_20) -- DC_GENERATOR
var volatile lamp lp17 = new_lamp(p33, mask_lamp_21) -- EXTERNAL_POWER
var volatile lamp lp18 = new_lamp(p34, mask_lamp_22) -- CHIP_DETECTOR
var volatile lamp lp19 = new_lamp(p35, mask_lamp_23) -- IFF

------------------------------------------------------------------------------------------------------------------------
-- Main Loop
------------------------------------------------------------------------------------------------------------------------
forever loop

    request_bootloader("pnl_b214")

    -- process objects
    cf = get_can_frame(id_id_lamps_0_31)
    if(cf.dlc > 0) then

        id_lamps_0_31 = get_can_uint32(cf)
        process_lamp(lp00, id_lamps_0_31)
        process_lamp(lp01, id_lamps_0_31)
        process_lamp(lp02, id_lamps_0_31)
        process_lamp(lp03, id_lamps_0_31)
        process_lamp(lp04, id_lamps_0_31)
        process_lamp(lp05, id_lamps_0_31)
        process_lamp(lp06, id_lamps_0_31)
        process_lamp(lp07, id_lamps_0_31)
        process_lamp(lp08, id_lamps_0_31)
        process_lamp(lp09, id_lamps_0_31)
        process_lamp(lp10, id_lamps_0_31)
        process_lamp(lp11, id_lamps_0_31)
        process_lamp(lp12, id_lamps_0_31)
        process_lamp(lp13, id_lamps_0_31)
        process_lamp(lp14, id_lamps_0_31)
        process_lamp(lp15, id_lamps_0_31)
        process_lamp(lp16, id_lamps_0_31)
        process_lamp(lp17, id_lamps_0_31)
        process_lamp(lp18, id_lamps_0_31)
        process_lamp(lp19, id_lamps_0_31)

    end if

end loop