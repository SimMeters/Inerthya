------------------------------------------------------------------------------------------------------------------------
-- Copyright (c) 2015, SimMeters.
-- All rights reserved. Released under the BSD license.
-- pnl_0232.jal 1.0 01/01/2015 (Collective and Cyclic Controller UH-1D project)

-- NOTES
-- Armament fire control switch Push Button NOT IMPLEMENTED
-- Cargo release switch Push Button NOT IMPLEMENTED
-- Hoist switch 4 way travel hat switch NOT IMPLEMENTED

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
var can_frame cf

var volatile sw3p sw00 = new_sw3p(p05, p06, P14, SEARCH_LIGHT_ON , SEARCH_LIGHT_OFF, SEARCH_LIGHT_STOW)
var volatile sw2p sw01 = new_sw2p(p07, P14, LAND_LIGHT_ON, LAND_LIGHT_OFF)
var volatile sw3p sw02 = new_sw3p(p08, p09, P14, GOVERNOR_INC, GOVERNOR_NOP, GOVERNOR_DEC)
var volatile sw3p sw03 = new_sw3p(p10, p11, P14, LAND_LIGHT_EXTR, LAND_LIGHT_NOP, LAND_LIGHT_RETR)
var volatile sw2p sw04 = new_sw2p(p12, P14, RELEASE_STARTER_ENG_1_ON, RELEASE_STARTER_ENG_1_OFF)
var volatile sw2p sw05 = new_sw2p(p32, P14, FORCE_TRIM_ON, FORCE_TRIM_OFF) 
var volatile sw2p sw06 = new_sw2p(p33, P14, RADIO_ICS_ON, RADIO_ICS_OFF)

------------------------------------------------------------------------------------------------------------------------
-- Main Loop
------------------------------------------------------------------------------------------------------------------------
forever loop

    request_bootloader("pnl_0232")

    -- process devices
    process_sw3p(sw00)
    process_sw2p(sw01)
    process_sw3p(sw02)
    process_sw3p(sw03)
	process_sw2p(sw04)
	process_sw2p(sw05)
	process_sw2p(sw06)
	
end loop