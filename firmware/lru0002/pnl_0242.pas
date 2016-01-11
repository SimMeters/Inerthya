------------------------------------------------------------------------------------------------------------------------
-- Copyright (c) 2015, SimMeters.
-- All rights reserved. Released under the BSD license.
-- pnl_0242.jal 1.0 01/01/2015 (A-10C Left MFCD)
-- Notes by PCB design is better to place RS3P DAY / NIGHT / OFF First

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
var volatile rs3p rs00 = new_rs3p(p10, p09, p08, p26, LMFCD_SEL_OFF, LMFCD_SEL_NIGHT, LMFCD_SEL_DAY)
var volatile sw2p sw00 = new_sw2p(p05, p27, LMFCD_OSB0_ON,  LMFCD_OSB0_OFF)
var volatile sw2p sw01 = new_sw2p(p06, p27, LMFCD_OSB1_ON,  LMFCD_OSB1_OFF)
var volatile sw2p sw02 = new_sw2p(p07, p27, LMFCD_OSB2_ON,  LMFCD_OSB2_OFF)
var volatile sw2p sw03 = new_sw2p(p08, p27, LMFCD_OSB3_ON,  LMFCD_OSB3_OFF)
var volatile sw2p sw04 = new_sw2p(p09, p27, LMFCD_OSB4_ON,  LMFCD_OSB4_OFF)
var volatile sw2p sw05 = new_sw2p(p10, p27, LMFCD_INC_DSP_ON, LMFCD_INC_DSP_OFF)
var volatile sw2p sw06 = new_sw2p(p05, p28, LMFCD_DEC_DSP_ON, LMFCD_DEC_DSP_OFF)
var volatile sw2p sw07 = new_sw2p(p06, p28, LMFCD_OSB5_ON,  LMFCD_OSB5_OFF)
var volatile sw2p sw08 = new_sw2p(p07, p28, LMFCD_OSB6_ON,  LMFCD_OSB6_OFF)
var volatile sw2p sw09 = new_sw2p(p08, p28, LMFCD_OSB7_ON,  LMFCD_OSB7_OFF)
var volatile sw2p sw10 = new_sw2p(p09, p28, LMFCD_OSB8_ON,  LMFCD_OSB8_OFF)
var volatile sw2p sw11 = new_sw2p(p10, p28, LMFCD_OSB9_ON,  LMFCD_OSB9_OFF)
var volatile sw2p sw12 = new_sw2p(p05, p29, LMFCD_INC_BRT_ON, LMFCD_INC_BRT_OFF)
var volatile sw2p sw13 = new_sw2p(p06, p29, LMFCD_DEC_BRT_ON, LMFCD_DEC_BRT_OFF)
var volatile sw2p sw14 = new_sw2p(p07, p29, LMFCD_INC_SYM_ON, LMFCD_INC_SYM_OFF)
var volatile sw2p sw15 = new_sw2p(p08, p29, LMFCD_DEC_SYM_ON, LMFCD_DEC_SYM_OFF)
var volatile sw2p sw16 = new_sw2p(p09, p29, LMFCD_OSB10_ON, LMFCD_OSB10_OFF)
var volatile sw2p sw17 = new_sw2p(p10, p29, LMFCD_OSB11_ON, LMFCD_OSB11_OFF)
var volatile sw2p sw18 = new_sw2p(p05, p30, LMFCD_OSB12_ON, LMFCD_OSB12_OFF)
var volatile sw2p sw19 = new_sw2p(p06, p30, LMFCD_OSB13_ON, LMFCD_OSB13_OFF)
var volatile sw2p sw20 = new_sw2p(p07, p30, LMFCD_OSB14_ON, LMFCD_OSB14_OFF)
var volatile sw2p sw21 = new_sw2p(p09, p30, LMFCD_INC_CON_ON, LMFCD_INC_CON_OFF)
var volatile sw2p sw22 = new_sw2p(p08, p30, LMFCD_DEC_CON_ON, LMFCD_DEC_CON_OFF)
var volatile sw2p sw23 = new_sw2p(p10, p30, LMFCD_OSB15_ON, LMFCD_OSB15_OFF)
var volatile sw2p sw24 = new_sw2p(p05, p31, LMFCD_OSB16_ON, LMFCD_OSB16_OFF)
var volatile sw2p sw25 = new_sw2p(p06, p31, LMFCD_OSB17_ON, LMFCD_OSB17_OFF)
var volatile sw2p sw26 = new_sw2p(p07, p31, LMFCD_OSB18_ON, LMFCD_OSB18_OFF)
var volatile sw2p sw27 = new_sw2p(p08, p31, LMFCD_OSB19_ON, LMFCD_OSB19_OFF)
var volatile sw2p sw28 = new_sw2p(p09, p31, LMFCD_INC_ADJ_ON, LMFCD_INC_ADJ_OFF)
var volatile sw2p sw29 = new_sw2p(p10, p31, LMFCD_DEC_ADJ_ON, LMFCD_DEC_ADJ_OFF)

------------------------------------------------------------------------------------------------------------------------
-- Main Loop
------------------------------------------------------------------------------------------------------------------------
forever loop 

    -- request bootloader for auto update (do not remove)
    request_bootloader("pnl_0242")

    -- process devices
    process_rs3p(rs00)
    process_sw2p(sw00)
    process_sw2p(sw01)
    process_sw2p(sw02)
    process_sw2p(sw03)
    process_sw2p(sw04)
    process_sw2p(sw05)
    process_sw2p(sw06)
    process_sw2p(sw07)
    process_sw2p(sw08)
    process_sw2p(sw09)
    process_sw2p(sw10)
    process_sw2p(sw11)
    process_sw2p(sw12)
    process_sw2p(sw13)
    process_sw2p(sw14)
    process_sw2p(sw15)
    process_sw2p(sw16)
    process_sw2p(sw17)
    process_sw2p(sw18)
    process_sw2p(sw19)
    process_sw2p(sw20)
    process_sw2p(sw21)
    process_sw2p(sw22)
    process_sw2p(sw23)
    process_sw2p(sw24)
    process_sw2p(sw25)
    process_sw2p(sw26)
    process_sw2p(sw27)
    process_sw2p(sw28)
    process_sw2p(sw29)

end loop