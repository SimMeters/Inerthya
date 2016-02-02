------------------------------------------------------------------------------------------------------------------------
-- Copyright (c) 2015, SimMeters.
-- All rights reserved. Released under the BSD license.
-- pnl_0245.jal 1.0 01/01/2015 (A-10C AHCP Panel)

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
var volatile sw3p sw01 = new_sw3p(p05, p06, P14, MASTER_ARM_ON, MASTER_ARM_SAFE, MASTER_ARM_TRAIN)
var volatile sw3p sw02 = new_sw3p(p07, p08, P14, GUNPAC_ARM, GUNPAC_SAFE, GUNPAC_GUNARM)
var volatile sw3p sw03 = new_sw3p(p09, p10, P14, LASER_ARM, LASER_SAFE, LASER_TRAIN) 
var volatile sw2p sw04 = new_sw2p(p11, P14, TGP_ON, TGP_OFF) 
var volatile sw3p sw05 = new_sw3p(p12, p32, P14, ALT_SCE_BARO, ALT_SCE_DELTA, ALT_SCE_RADAR) 
var volatile sw2p sw06 = new_sw2p(p33, P14, HUD_MODE_DAY, HUD_MODE_NIGHT) 
var volatile sw2p sw07 = new_sw2p(p34, P14, HUD_MODE_NORMAL, HUD_MODE_STBY) 
var volatile sw2p sw08 = new_sw2p(p35, P14, CICU_ON, CICU_OFF) 
var volatile sw2p sw09 = new_sw2p(p36, P14, JTRS_ON, JTRS_OFF) 
var volatile sw3p sw10 = new_sw3p(p37, p38, P14, IFCC_ON, IFCC_TEST, IFCC_OFF) 

------------------------------------------------------------------------------------------------------------------------
-- Main Loop
------------------------------------------------------------------------------------------------------------------------
forever loop 

    -- request bootloader for auto update (do not remove)
    request_bootloader("pnl_0245")

    -- process devices to canbus
    process_sw3p(sw01)
    process_sw3p(sw02)
    process_sw3p(sw03)
    process_sw2p(sw04)
    process_sw3p(sw05)
    process_sw2p(sw06)
    process_sw2p(sw07)
    process_sw2p(sw08)
    process_sw2p(sw09)
    process_sw3p(sw10)

end loop