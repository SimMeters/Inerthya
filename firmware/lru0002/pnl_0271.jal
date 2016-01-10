------------------------------------------------------------------------------------------------------------------------
-- Copyright (c) 2015, SimMeters.
-- All rights reserved. Released under the BSD license.
-- pnl_0271.jal 1.0 01/01/2015 (A-10C Navigation Display Panel)

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
add_can_rxfilter(ID_REQUEST_BOOTLOADER)
setup_can_end()

set_pin(P21, low)
set_pin(P22, high)

------------------------------------------------------------------------------------------------------------------------
-- Objects Definition
------------------------------------------------------------------------------------------------------------------------
var volatile rs3p rs00 = new_rs3p(p05, p06, p07, P14, STEER_FLTPLAN, STEER_MARK, STEER_MISSION)
var volatile sw2p sw00 = new_sw2p(p08, P14, CDU_POWER_ON, CDU_POWER_OFF)
var volatile sw2p sw01 = new_sw2p(p09, P14, EGI_POWER_ON, EGI_POWER_OFF)
var volatile sw3p sw02 = new_sw3p(p10, p11, P14, STEER_UP, STEER_OFF, STEER_DOWN)
var volatile rs4p rs01 = new_rs4p(p12, p32, p33, p34, P14, PAGE_OTHER, PAGE_POSITION, PAGE_STEER, PAGE_WAYPT)

------------------------------------------------------------------------------------------------------------------------
-- Main Loop
------------------------------------------------------------------------------------------------------------------------
forever loop  

    -- request bootloader for auto update (do not remove)
    request_bootloader("pnl_0271")

    -- process devices to canbus
    process_rs3p(rs00)
    process_sw2p(sw00)
    process_sw2p(sw01)
    process_sw3p(sw02)
    process_rs4p(rs01)

end loop