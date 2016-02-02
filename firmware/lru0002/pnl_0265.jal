------------------------------------------------------------------------------------------------------------------------
-- Copyright (c) 2015, SimMeters.
-- All rights reserved. Released under the BSD license.
-- pnl_0265.jal 1.0 01/01/2015 (A-10C EW Panel)
-- notes todo integrate Displays and get data from DCS Lua not present at the moment

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
var volatile sw2p sw00 = new_sw2p(p05, P14, EW_OSB1_ON, EW_OSB1_OFF)
var volatile sw2p sw01 = new_sw2p(p05, p15, EW_OSB2_ON, EW_OSB2_OFF)
var volatile sw2p sw02 = new_sw2p(p05, p16, EW_OSB3_ON, EW_OSB3_OFF)
var volatile sw2p sw03 = new_sw2p(p05, p17, EW_OSB4_ON, EW_OSB4_OFF)
var volatile sw2p sw04 = new_sw2p(p05, p18, EW_NXT_DOWN_ON, EW_NXT_DOWN_OFF)
var volatile sw2p sw05 = new_sw2p(p05, p26, EW_NXT_UP_ON, EW_NXT_UP_OFF)
var volatile sw2p sw06 = new_sw2p(p05, p27, EW_RTN_ON, EW_RTN_OFF)
var volatile sw3p sw07 = new_sw3p(p06, p07,  p28, EW_MWS_UP, EW_MWS_CENTER, EW_MWS_DOWN)
var volatile sw3p sw08 = new_sw3p(p08, p09,  p28, EW_JMR_UP, EW_JMR_CENTER, EW_JMR_DOWN)
var volatile sw3p sw09 = new_sw3p(p10, p11,  p28, EW_RWR_UP, EW_RWR_CENTER, EW_RWR_DOWN)
var volatile sw3p sw10 = new_sw3p(p12, p32,  p28, EW_DISP_UP, EW_DISP_CENTER, EW_DISP_DOWN)
var volatile sw2p sw11 = new_sw2p(p33, p28, EW_JTSN_ON, EW_JTSN_OFF)
var volatile rs5p rs00 = new_rs5p(p34, p35, p36, p37, p38, p28, EW_MODE_OFF, EW_MODE_STBY, EW_MODE_MAN, EW_MODE_SEMI, EW_MODE_AUTO)

------------------------------------------------------------------------------------------------------------------------
-- Main Loop
------------------------------------------------------------------------------------------------------------------------
forever loop 

    -- request bootloader for auto update (do not remove)
    request_bootloader("pnl_0265")

    -- process devices to canbus
    process_sw2p(sw00)
    process_sw2p(sw01)
    process_sw2p(sw02)
    process_sw2p(sw03)
    process_sw2p(sw04)
    process_sw2p(sw05)
    process_sw2p(sw06)
    process_sw3p(sw07)
    process_sw3p(sw08)
    process_sw3p(sw09)
    process_sw3p(sw10)
    process_sw2p(sw11)
    process_rs5p(rs00)

end loop