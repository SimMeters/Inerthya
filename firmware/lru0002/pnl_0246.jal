------------------------------------------------------------------------------------------------------------------------
-- Copyright (c) 2015, SimMeters.
-- All rights reserved. Released under the BSD license.
-- pnl_0246.jal 1.0 01/01/2015 (MIP AHRS NAV PANEL)
-- NOTES: On the Output Use ps 29 and 30 for UHF / FM

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
include atachapters  -- Constants for ATA Chapters
include canaerospace -- Constants for CANAerospace
include lru0002       -- Include For LRU Device Type
include canbus       -- CanBus Library
include objects      -- Objects Library

------------------------------------------------------------------------------------------------------------------------
-- Initialization
------------------------------------------------------------------------------------------------------------------------
_usec_delay(1000000)

setup_can_init()
add_can_rxfilter(id_request_bootloader)
add_can_rxfilter(id_lamps_32_63)
setup_can_end()

set_pin(P21, low)
set_pin(P22, high)

------------------------------------------------------------------------------------------------------------------------
-- Objects Definition
------------------------------------------------------------------------------------------------------------------------
var can_frame cf
var dword lamps_32_63

var volatile lamp lp00 = new_lamp(p15, mask_lamp_18) -- HARS
var volatile lamp lp01 = new_lamp(p16, mask_lamp_19) -- EGI
var volatile lamp lp02 = new_lamp(p17, mask_lamp_20) -- TISL
var volatile lamp lp03 = new_lamp(p18, mask_lamp_21) -- STEER
var volatile lamp lp04 = new_lamp(p26, mask_lamp_22) -- ANCHR
var volatile lamp lp05 = new_lamp(p27, mask_lamp_23) -- TCN
var volatile lamp lp06 = new_lamp(p28, mask_lamp_24) -- ILS
var volatile lamp lp07 = new_lamp(p29, mask_lamp_25) -- UHF
var volatile lamp lp08 = new_lamp(p30, mask_lamp_26) -- FM

var volatile sw2p sw00 = new_sw2p(p05, P14, NMSP_HARS_ON,   NMSP_HARS_OFF)
var volatile sw3p sw01 = new_sw3p(p06, p07,  P14,   NMSP_PTR_ABLE, NMSP_PTR_OFF, NMSP_PTR_STOW) 
var volatile sw2p sw02 = new_sw2p(p08, P14, NMSP_EGI_ON,    NMSP_EGI_OFF)
var volatile sw2p sw03 = new_sw2p(p09, P14, NMSP_TISL_ON,   NMSP_TISL_OFF)
var volatile sw2p sw04 = new_sw2p(p10, P14, NMSP_STEER_ON,  NMSP_STEER_OFF)
var volatile sw2p sw05 = new_sw2p(p11, P14, NMSP_ANCHR_ON,  NMSP_ANCHR_OFF)
var volatile sw2p sw06 = new_sw2p(p12, P14, NMSP_TCN_ON,    NMSP_TCN_OFF)
var volatile sw2p sw07 = new_sw2p(p32, P14, NMSP_ILS_ON,    NMSP_ILS_OFF)

------------------------------------------------------------------------------------------------------------------------
-- Main Loop
------------------------------------------------------------------------------------------------------------------------
forever loop 

    -- request bootloader for auto update (do not remove)
    request_bootloader("pnl_0246")

    -- process lamps
    cf = get_can_frame(id_lamps_32_63)
    if(cf.dlc > 0) then

        lamps_32_63 = get_can_uint32(cf)
        process_lamp(lp00, lamps_32_63)
        process_lamp(lp01, lamps_32_63)
        process_lamp(lp02, lamps_32_63)
        process_lamp(lp03, lamps_32_63)
        process_lamp(lp04, lamps_32_63)
        process_lamp(lp05, lamps_32_63)
        process_lamp(lp06, lamps_32_63)
        process_lamp(lp07, lamps_32_63)
        process_lamp(lp08, lamps_32_63)

    end if

    -- process devices
    process_sw2p(sw00)
    process_sw3p(sw01)
    process_sw2p(sw02)
    process_sw2p(sw03)
    process_sw2p(sw04)
    process_sw2p(sw05)
    process_sw2p(sw06)
    process_sw2p(sw07)

end loop