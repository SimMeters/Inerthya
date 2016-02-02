------------------------------------------------------------------------------------------------------------------------
-- Copyright (c) 2015, SimMeters.
-- All rights reserved. Released under the BSD license.
-- pnl_0244.jal 1.0 01/01/2015 (A-10C Landing Gear Panel)

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
add_can_rxfilter(id_lamps_64_95)
setup_can_end()

set_pin(P21, low)
set_pin(P22, high)

------------------------------------------------------------------------------------------------------------------------
-- Objects Definition
------------------------------------------------------------------------------------------------------------------------
var can_frame cf
var dword lamps_32_63
var dword lamps_64_95

var volatile lamp lp00 = new_lamp(p15, mask_lamp_31) -- gear handle
var volatile lamp lp01 = new_lamp(p16, mask_lamp_00) -- n_safe
var volatile lamp lp02 = new_lamp(p17, mask_lamp_01) -- l_safe
var volatile lamp lp03 = new_lamp(p18, mask_lamp_02) -- r_safe

var volatile sw2p sw00 = new_sw2p(p05, P14, ANTI_SKID_ON, ANTI_SKID_OFF) 
var volatile sw3p sw01 = new_sw3p(p06, p07,  P14, LAND_LIGHT_ON, LAND_LIGHT_OFF, LAND_LIGHT_TAXI)
var volatile sw2p sw02 = new_sw2p(p08, P14, DOWNLOCK_OVERRIDE_ON, DOWNLOCK_OVERRIDE_OFF) 
var volatile sw2p sw03 = new_sw2p(p09, P14, LANDING_GEAR_DOWN, LANDING_GEAR_UP) 
var volatile sw2p sw04 = new_sw2p(p10, P14, TEMS_DATA_ON, TEMS_DATA_OFF) 

------------------------------------------------------------------------------------------------------------------------
-- Main Loop
------------------------------------------------------------------------------------------------------------------------
forever loop 

    -- request bootloader for auto update (do not remove)
    request_bootloader("pnl_0244")

    -- process lamps
    cf = get_can_frame(ID_lampS_32_63)
    if(cf.dlc > 0) then

        lamps_32_63 = get_can_uint32(cf)
        process_lamp(lp00, lamps_32_63)    

    end if

    cf = get_can_frame(ID_lampS_64_95)
    if(cf.dlc > 0) then

        lamps_64_95 = get_can_uint32(cf)
        process_lamp(lp01, lamps_64_95)    
        process_lamp(lp02, lamps_64_95)    
        process_lamp(lp03, lamps_64_95)    

    end if

    -- process devices
    process_sw2p(sw00)
    process_sw3p(sw01)
    process_sw2p(sw02)
    process_sw2p(sw03)
    process_sw2p(sw04)

end loop