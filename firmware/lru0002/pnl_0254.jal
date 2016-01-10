------------------------------------------------------------------------------------------------------------------------
-- Copyright (c) 2015, SimMeters.
-- All rights reserved. Released under the BSD license.
-- pnl_0254.jal 1.0 01/01/2015 (A-10C SAS Panel)

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
include lru0002      -- Include For LRU Device Type
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

var volatile lamp lp00 = new_lamp(p27, MASK_LAMP_29)

var volatile sw2p sw00 = new_sw2p(p32, p26, YAW_SAS_L_ENGAGE, YAW_SAS_L_OFF)
var volatile sw2p sw01 = new_sw2p(p33, p26, YAW_SAS_R_ENGAGE, YAW_SAS_R_OFF)
var volatile sw2p sw02 = new_sw2p(p34, p26, PITCH_SAS_L_ENGAGE, PITCH_SAS_L_OFF)
var volatile sw2p sw03 = new_sw2p(p35, p26, PITCH_SAS_R_ENGAGE, PITCH_SAS_R_OFF)
var volatile sw3p sw04 = new_sw3p(p36, p37, p26, SAS_MONITOR_TEST_L, SAS_MONITOR_TEST_OFF, SAS_MONITOR_TEST_R)
var volatile sw2p sw05 = new_sw2p(p39, p26, TAKE_OFF_TRIM_BTTN_PUSHED, TAKE_OFF_TRIM_BTTN_RELEASED)

--Yaw Trim Potentiometer AN0
var volatile pot pt00 = new_pot(p14, 0xBEEF0000) -- test

------------------------------------------------------------------------------------------------------------------------
-- Main Loop
------------------------------------------------------------------------------------------------------------------------
forever loop 

    -- request bootloader for auto update (do not remove)
    request_bootloader("pnl_0254")

    -- process lamp
    cf = get_can_frame(id_lamps_32_63)
    if(cf.dlc > 0) then

        lamps_32_63 = get_can_uint32(cf)
        process_lamp(lp00, lamps_32_63)    

    end if

    -- process devices to canbus
    process_sw2p(sw00)
    process_sw2p(sw01)
    process_sw2p(sw02)
    process_sw2p(sw03)
    process_sw3p(sw04)
    process_sw2p(sw05)

    -- process pot
    process_pot(pt00)

end loop