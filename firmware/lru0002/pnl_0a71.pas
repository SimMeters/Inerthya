------------------------------------------------------------------------------------------------------------------------
-- Copyright (c) 2015, SimMeters.
-- All rights reserved. Released under the BSD license.
-- pnl_0a71.jal 1.0 01/01/2015 (General Aviation BOX LRU1 Do-27 project)

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

set_pin(P21, low)
set_pin(P22, high)

------------------------------------------------------------------------------------------------------------------------
-- Objects Definition
------------------------------------------------------------------------------------------------------------------------
var volatile lamp lp00 = new_lamp(P14, mask_lamp_19)                                -- L-ENG HOT
var volatile lamp lp01 = new_lamp(p15, mask_lamp_27)                                -- L-MAIN PUMP

var volatile sw2p sw00 = new_sw2p(p05, p23, BATTERY_POWER_ON, BATTERY_POWER_OFF)    -- MASTER BAT
var volatile sw2p sw01 = new_sw2p(p08, p23, STARTER_ON, STARTER_OFF)                -- STARTER
var volatile sw2p sw02 = new_sw2p(p09, p23, FUEL_PUMP_ON, FUEL_PUMP_OFF)            -- FUEL PUMP
var volatile sw2p sw03 = new_sw2p(p10, p23, PITOT_HEAT_ON, PITOT_HEAT_OFF)          -- PITOT HEAT
var volatile sw2p sw04 = new_sw2p(p32, p23, LAND_LIGHT_ON, LAND_LIGHT_OFF)          -- LAND LIGHTS
var volatile sw2p sw05 = new_sw2p(p33, p23, TAXI_LIGHT_ON, TAXI_LIGHT_OFF)          -- TAXI LIGHTS
var volatile sw2p sw06 = new_sw2p(p34, p23, ANTICOLLISION_ON, ANTICOLLISION_OFF)    -- NAV LIGHTS
var volatile sw2p sw07 = new_sw2p(p35, p23, POSITION_FLASH, POSITION_OFF)           -- STROBE
var volatile sw2p sw08 = new_sw2p(p37, p23, PARKING_BRAKE_ON, PARKING_BRAKE_OFF)    -- PARKING BRAKE

------------------------------------------------------------------------------------------------------------------------
-- Main Loop
------------------------------------------------------------------------------------------------------------------------
forever loop

    request_bootloader("pnl_0a71")

    -- process objects
    process_sw2p(sw00)
    process_sw2p(sw01)
    process_sw2p(sw02)
    process_sw2p(sw03)
    process_sw2p(sw04)
    process_sw2p(sw05)
    process_sw2p(sw06)
    process_sw2p(sw07)
    process_sw2p(sw08)

    -- process lamps
    cf = get_can_frame(id_lamps_0_31)
    if(cf.dlc > 0) then

        lamps_0_31 = get_can_uint32(cf)
        process_lamp(lp00, lamps_0_31)
        process_lamp(lp01, lamps_0_31)

    end if

end loop