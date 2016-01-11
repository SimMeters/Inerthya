------------------------------------------------------------------------------------------------------------------------
-- Copyright (c) 2015, SimMeters.
-- All rights reserved. Released under the BSD license.
-- pnl_0272.jal 1.0 01/01/2015 (A-10C Environment Panel)

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
setup_can_end()

set_pin(P21, low)
set_pin(P22, high)

------------------------------------------------------------------------------------------------------------------------
-- Objects Definition
------------------------------------------------------------------------------------------------------------------------
var volatile sw2p sw00 = new_sw2p(p05, P14, OXY_IND_TEST_ON, OXY_IND_TEST_OFF)
var volatile sw2p sw01 = new_sw2p(p06, P14, WINDSHIELD_DEICE_ON, WINDSHIELD_DEICE_OFF)
var volatile sw3p sw02 = new_sw3p(p07, p08, P14, WINDSHIELD_MODE_RAIN, WINDSHIELD_MODE_OFF, WINDSHIELD_MODE_WASH) --new WINDSHIELD_MODE_OFF and 3POS TOGGLE
var volatile sw2p sw03 = new_sw2p(p09, P14, PITOT_HEAT_ON, PITOT_HEAT_OFF)
var volatile sw2p sw04 = new_sw2p(p10, P14, BLEED_AIR_ON, BLEED_AIR_OFF)
var volatile sw3p sw05 = new_sw3p(p11, p12, P14, TEMP_PRESS_NORM, TEMP_PRESS_DUMP, TEMP_PRESS_RAM) -- new TEMP_PRESS_DUMP and 3 POS
var volatile sw2p sw06 = new_sw2p(p32, P14, MAIN_SUPPLY_ON, MAIN_SUPPLY_OFF)
var volatile sw2p sw07 = new_sw2p(p33, P14, MODE_MANUAL, MODE_AUTO)

------------------------------------------------------------------------------------------------------------------------
-- Main Loop
------------------------------------------------------------------------------------------------------------------------
forever loop 

    -- request bootloader for auto update (do not remove)
    request_bootloader("pnl_0272")

    -- process devices to canbus
    process_sw2p(sw00)
    process_sw2p(sw01)
    process_sw3p(sw02)
    process_sw2p(sw03)
    process_sw2p(sw04)
    process_sw3p(sw05)
    process_sw2p(sw06)
    process_sw2p(sw07)

end loop