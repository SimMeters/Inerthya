------------------------------------------------------------------------------------------------------------------------
-- Copyright (c) 2015, SimMeters.
-- All rights reserved. Released under the BSD license.
-- pnl_0263.jal 1.0 01/01/2015 (A-10C RCU Panel) Todo MAP

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
var volatile sw2p sw00 = new_sw2p(p05, P14, SECURE_VOICE_CONTROL_ZEROIZE_ON, SECURE_VOICE_CONTROL_ZEROIZE_OFF)-- Zeroize Switch with switchguard
var volatile sw2p sw01 = new_sw2p(p06, P14, SECURE_VOICE_CONTROL_DELAY_ON, SECURE_VOICE_CONTROL_DELAY_OFF)
var volatile rs6p rs00 = new_RS6P(p07, p08, p09, p10, p11, p12 ,P14, SECURE_VOICE_CONTROL_ENCRYPTION_CODE1 , SECURE_VOICE_CONTROL_ENCRYPTION_CODE2 , SECURE_VOICE_CONTROL_ENCRYPTION_CODE3 , SECURE_VOICE_CONTROL_ENCRYPTION_CODE4 , SECURE_VOICE_CONTROL_ENCRYPTION_CODE5 , SECURE_VOICE_CONTROL_ENCRYPTION_CODE6 )
var volatile sw2p sw02 = new_sw2p(p32, P14, SECURE_VOICE_CONTROL_POWER_ON, SECURE_VOICE_CONTROL_POWER_OFF)
var volatile rs3p rs01 = new_rs3p(p33, p34, p35, P14, SECURE_VOICE_CONTROL_RADIO_SELECT_CRAD1, SECURE_VOICE_CONTROL_RADIO_SELECT_PLAIN, SECURE_VOICE_CONTROL_RADIO_SELECT_CRAD2)
var volatile rs3p rs02 = new_rs3p(p36, p37, p38, P14, SECURE_VOICE_CONTROL_MODE_OP, SECURE_VOICE_CONTROL_MODE_LD, SECURE_VOICE_CONTROL_MODE_RV)

------------------------------------------------------------------------------------------------------------------------
-- Main Loop
------------------------------------------------------------------------------------------------------------------------
forever loop 

    -- request bootloader for auto update (do not remove)
    request_bootloader("pnl_0263")

    -- process devices to canbus
    process_sw2p(sw00)
    process_sw2p(sw01)
    process_rs6p(rs00)
    process_sw2p(sw02)
    process_rs3p(rs01)
    process_rs3p(rs02)

end loop