------------------------------------------------------------------------------------------------------------------------
-- Copyright (c) 2015, SimMeters.
-- All rights reserved. Released under the BSD license.
-- pnl_a267.jal 1.0 01/01/2015 (A10C Anunciator lamps Panel LRU-A)

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

var volatile lamp lp00 = new_lamp(p05, mask_lamp_02) -- ENG START CYCLE
var volatile lamp lp01 = new_lamp(p06, mask_lamp_03) -- L-HYD PRESS
var volatile lamp lp02 = new_lamp(p07, mask_lamp_04) -- R-HYD PRESS
var volatile lamp lp03 = new_lamp(p08, mask_lamp_05) -- GUN UNSAFE
var volatile lamp lp04 = new_lamp(p09, mask_lamp_06) -- ANTI SKID
var volatile lamp lp05 = new_lamp(p10, mask_lamp_07) -- L-HYD RES
var volatile lamp lp06 = new_lamp(p11, mask_lamp_08) -- R-HYD RES
var volatile lamp lp07 = new_lamp(p12, mask_lamp_09) -- OXY LOW
var volatile lamp lp08 = new_lamp(P14, mask_lamp_10) -- ELEV DISENG
var volatile lamp lp09 = new_lamp(p15, mask_lamp_11) -- VOID 1
var volatile lamp lp10 = new_lamp(p16, mask_lamp_12) -- SEAT NOT ARMED
var volatile lamp lp11 = new_lamp(p17, mask_lamp_13) -- BLEED AIR LEAK
var volatile lamp lp12 = new_lamp(p18, mask_lamp_14) -- AIL DISENG
var volatile lamp lp13 = new_lamp(p23, mask_lamp_15) -- L-AIL TAB
var volatile lamp lp14 = new_lamp(p26, mask_lamp_16) -- R-AIL TAB
var volatile lamp lp15 = new_lamp(p27, mask_lamp_17) -- SERVICE AIR HOT
var volatile lamp lp16 = new_lamp(p28, mask_lamp_18) -- PITCH SAS
var volatile lamp lp17 = new_lamp(p29, mask_lamp_19) -- L-ENG HOT
var volatile lamp lp18 = new_lamp(p30, mask_lamp_20) -- R-ENG HOT
var volatile lamp lp19 = new_lamp(p31, mask_lamp_21) -- WINDSHIELD HOT
var volatile lamp lp20 = new_lamp(p32, mask_lamp_22) -- YAW SAS
var volatile lamp lp21 = new_lamp(p33, mask_lamp_23) -- L-ENG OIL PRESS
var volatile lamp lp22 = new_lamp(p34, mask_lamp_24) -- R-ENG OIL PRESS
var volatile lamp lp23 = new_lamp(p35, mask_lamp_25) -- CICU

------------------------------------------------------------------------------------------------------------------------
-- Main Loop
------------------------------------------------------------------------------------------------------------------------
forever loop 

    -- request bootloader for auto update (do not remove)
    request_bootloader("pnl_a267")

    -- process lamps
    cf = get_can_frame(id_lamps_0_31)
    if(cf.dlc > 0) then

        lamps_0_31 = get_can_uint32(cf)
        process_lamp(lp00, lamps_0_31)    
        process_lamp(lp01, lamps_0_31)    
        process_lamp(lp02, lamps_0_31)    
        process_lamp(lp03, lamps_0_31)    
        process_lamp(lp04, lamps_0_31)    
        process_lamp(lp05, lamps_0_31)    
        process_lamp(lp06, lamps_0_31)    
        process_lamp(lp07, lamps_0_31)    
        process_lamp(lp08, lamps_0_31)    
        process_lamp(lp09, lamps_0_31)    
        process_lamp(lp10, lamps_0_31)    
        process_lamp(lp11, lamps_0_31)    
        process_lamp(lp12, lamps_0_31)    
        process_lamp(lp13, lamps_0_31)    
        process_lamp(lp14, lamps_0_31)    
        process_lamp(lp15, lamps_0_31)    
        process_lamp(lp16, lamps_0_31)    
        process_lamp(lp17, lamps_0_31)    
        process_lamp(lp18, lamps_0_31)    
        process_lamp(lp19, lamps_0_31)    
        process_lamp(lp20, lamps_0_31)    
        process_lamp(lp21, lamps_0_31)    
        process_lamp(lp22, lamps_0_31)    
        process_lamp(lp23, lamps_0_31)    

    end if

end loop