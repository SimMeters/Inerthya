------------------------------------------------------------------------------------------------------------------------
-- Copyright (c) 2015, SimMeters.
-- All rights reserved. Released under the BSD license.
-- pnl_0240.jal 1.0 01/01/2015 (A-10C UFC)
-- Notes Make Revision 2 of PCB problems with the Switches Bridge.

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
add_can_rxfilter(id_lamps_0_31)
setup_can_end()

set_pin(P21, low)
set_pin(P22, high)

------------------------------------------------------------------------------------------------------------------------
-- Objects Definition
------------------------------------------------------------------------------------------------------------------------
var can_frame cf
var dword lamps_0_31

var volatile lamp lp00 = new_lamp(P21, mask_lamp_01) -- MASTER CAUTION

var volatile sw2p sw00 = new_sw2p(p05, P14, UFC_STEER_DEC_ON, UFC_STEER_DEC_OFF) 
var volatile sw2p sw01 = new_sw2p(p06, P14, UFC_STEER_INC_ON, UFC_STEER_INC_OFF) 
var volatile sw2p sw02 = new_sw2p(p07, P14, UFC_OSB_1_ON, UFC_OSB_1_OFF) 
var volatile sw2p sw03 = new_sw2p(p08, P14, UFC_OSB_2_ON, UFC_OSB_2_OFF) 
var volatile sw2p sw04 = new_sw2p(p09, P14, UFC_OSB_3_ON, UFC_OSB_3_OFF) 
var volatile sw2p sw05 = new_sw2p(p10, P14, UFC_OSB_HACK_ON, UFC_OSB_HACK_OFF) 
var volatile sw2p sw06 = new_sw2p(p11, P14, UFC_OSB_ENT_ON, UFC_OSB_ENT_OFF) 
var volatile sw2p sw07 = new_sw2p(p12, P14, UFC_OSB_FUNC_ON, UFC_OSB_FUNC_OFF) 

var volatile sw2p sw08 = new_sw2p(p05, p15, UFC_OSB_4_ON, UFC_OSB_4_OFF) 
var volatile sw2p sw09 = new_sw2p(p06, p15, UFC_OSB_5_ON, UFC_OSB_5_OFF) 
var volatile sw2p sw10 = new_sw2p(p07, p15, UFC_OSB_6_ON, UFC_OSB_6_OFF) 
var volatile sw2p sw11 = new_sw2p(p08, p15, UFC_OSB_0_ON, UFC_OSB_0_OFF) 
var volatile sw2p sw12 = new_sw2p(p09, p15, UFC_OSB_LTR_ON, UFC_OSB_LTR_OFF) 
var volatile sw2p sw13 = new_sw2p(p10, p15, UFC_OSB_MK_ON, UFC_OSB_MK_OFF) 
--var volatile sw2p sw14 = new_sw2p(p11, p15, 0x00020701, 0x00020700) 
--var volatile sw2p sw15 = new_sw2p(p12, p15, 0x00020801, 0x00020800) 

var volatile sw2p sw16 = new_sw2p(p05, p16, UFC_OSB_7_ON, UFC_OSB_7_OFF) 
var volatile sw2p sw17 = new_sw2p(p06, p16, UFC_OSB_8_ON, UFC_OSB_8_OFF) 
var volatile sw2p sw18 = new_sw2p(p07, p16, UFC_OSB_9_ON, UFC_OSB_9_OFF) 
var volatile sw2p sw19 = new_sw2p(p08, p16, UFC_OSB_SPC_ON, UFC_OSB_SPC_OFF) 
var volatile sw2p sw20 = new_sw2p(p09, p16, UFC_OSB_CLR_ON, UFC_OSB_CLR_OFF) 
var volatile sw2p sw21 = new_sw2p(p10, p16, UFC_OSB_ALT_ON, UFC_OSB_ALT_OFF) 
--var volatile sw2p sw22 = new_sw2p(p11, p16, 0x00030701, 0x00030700) 
--var volatile sw2p sw23 = new_sw2p(p12, p16, 0x00030801, 0x00030800) 

--var volatile sw2p sw24 = new_sw2p(p05, p17, 0x00040101, 0x00040100) 
var volatile sw2p sw25 = new_sw2p(p06, p17, UFC_DEPR_DEC_ON, UFC_DEPR_DEC_OFF) 
var volatile sw2p sw26 = new_sw2p(p07, p17, UFC_DEPR_INC_ON, UFC_DEPR_INC_OFF) 
var volatile sw2p sw27 = new_sw2p(p08, p17, UFC_SEL_DEC_ON, UFC_SEL_DEC_OFF) 
var volatile sw2p sw28 = new_sw2p(p09, p17, UFC_SEL_INC_ON, UFC_SEL_INC_OFF) 
var volatile sw2p sw29 = new_sw2p(p10, p17, UFC_DATA_DEC_ON, UFC_DATA_DEC_OFF) 
var volatile sw2p sw30 = new_sw2p(p11, p17, UFC_DATA_INC_ON, UFC_DATA_INC_OFF) 
var volatile sw2p sw31 = new_sw2p(p12, p17, UFC_OSB_MASTER_ON, UFC_OSB_MASTER_OFF) 

--var volatile sw2p sw32 = new_sw2p(p05, p18, 0x00050101, 0x00050100) 
var volatile sw2p sw33 = new_sw2p(p06, p18, UFC_INTEN_DEC_ON, UFC_INTEN_DEC_OFF) 
var volatile sw2p sw34 = new_sw2p(p07, p18, UFC_INTEN_INC_ON, UFC_INTEN_INC_OFF) 

------------------------------------------------------------------------------------------------------------------------
-- Main Loop
------------------------------------------------------------------------------------------------------------------------
forever loop 

    -- request bootloader for auto update (do not remove)
    request_bootloader("pnl_0240")

    -- process lamps
    cf = get_can_frame(id_lamps_0_31)
    if(cf.dlc > 0) then

        lamps_0_31 = get_can_uint32(cf)
        process_lamp(lp00, lamps_0_31)    

    end if
    
    -- process devices to canbus
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
    --process_sw2p(sw14)
    --process_sw2p(sw15)

    process_sw2p(sw16)
    process_sw2p(sw17)
    process_sw2p(sw18)
    process_sw2p(sw19)
    process_sw2p(sw20)
    process_sw2p(sw21)
    --process_sw2p(sw22)
    --process_sw2p(sw23)

    --process_sw2p(sw24)
    process_sw2p(sw25)
    process_sw2p(sw26)
    process_sw2p(sw27)
    process_sw2p(sw28)
    process_sw2p(sw29)
    process_sw2p(sw30)
    process_sw2p(sw31)

    --process_sw2p(sw32)
    process_sw2p(sw33)
    process_sw2p(sw34)

end loop