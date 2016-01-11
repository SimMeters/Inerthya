------------------------------------------------------------------------------------------------------------------------
-- Copyright (c) 2015, SimMeters.
-- All rights reserved. Released under the BSD license.
-- pnl_0138.jal 1.0 01/01/2015 (EC-135 MIP WARNING-UNIT)

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
add_can_rxfilter(id_lamps_0_31)
add_can_rxfilter(id_lamps_32_63)
setup_can_end()

set_pin(p21, low)
set_pin(p22, high)

------------------------------------------------------------------------------------------------------------------------
-- Objects Definition
------------------------------------------------------------------------------------------------------------------------
var can_frame cf

var dword lamps_0_31
var dword lamps_32_63

var volatile lamp lp00 = new_lamp(p05, mask_lamp_23) -- EMER_OFF_SW 1
var volatile lamp lp01 = new_lamp(p11, mask_lamp_24) -- EMER OFF SW 2
var volatile lamp lp02 = new_lamp(p12, mask_lamp_23) -- ACTIVE L
var volatile lamp lp03 = new_lamp(p23, mask_lamp_24) -- ACTIVE R
var volatile lamp lp04 = new_lamp(p28, mask_lamp_25) -- FIRE 1
var volatile lamp lp05 = new_lamp(p29, mask_lamp_26) -- FIRE 2
var volatile lamp lp06 = new_lamp(p30, mask_lamp_27) -- MASTER CAUTION
var volatile lamp lp07 = new_lamp(p08, mask_lamp_28) -- ROTOR RPM
var volatile lamp lp08 = new_lamp(p16, mask_lamp_29) -- XMSN OIL PRESSURE
var volatile lamp lp09 = new_lamp(p15, mask_lamp_30) -- BAT DISCH
var volatile lamp lp10 = new_lamp(p14, mask_lamp_31) -- BAT TEMP
var volatile lamp lp11 = new_lamp(p06, mask_lamp_00) -- LOW FUEL 1
var volatile lamp lp12 = new_lamp(p10, mask_lamp_01) -- LOW FUEL 2
var volatile lamp lp13 = new_lamp(p17, mask_lamp_02) -- AP A TRIM
var volatile lamp lp14 = new_lamp(p31, mask_lamp_03) -- ALT INDICATOR
var volatile lamp lp15 = new_lamp(p18, mask_lamp_04) -- CARGO SMOKE
var volatile lamp lp16 = new_lamp(p26, mask_lamp_05) -- CAT A
var volatile lamp lp17 = new_lamp(p27, mask_lamp_06) -- HI NR ACTIVE
--var volatile LAMP lp18 = new_lamp(p07, mask_lamp_07) --
--var volatile LAMP lp19 = new_lamp(p09, mask_lamp_08) --

var volatile sw1p sw00 = new_sw1p(P32, P07, EMER_OFF_1_TOOGLE)  
var volatile sw1p sw01 = new_sw1p(P33, P07, EMER_OFF_2_TOOGLE) 

------------------------------------------------------------------------------------------------------------------------
-- Main Loop
------------------------------------------------------------------------------------------------------------------------
forever loop 

    -- request bootloader for auto update (do not remove)
    request_bootloader("pnl_0138")
	
	 -- process lamps
    cf = get_can_frame(id_lamps_0_31)
    if(cf.dlc > 0) then

        LAMPS_0_31 = get_CAN_Uint32(cf)
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

	end if

	-- process lamps
    cf = get_CAN_Frame(ID_LAMPS_32_63)
    if(cf.dlc > 0) then

        LAMPS_32_63 = get_CAN_Uint32(cf)
        process_lamp(lp11, lamps_32_63)    
		process_lamp(lp12, lamps_32_63)    
		process_lamp(lp13, lamps_32_63)    
		process_lamp(lp14, lamps_32_63)    
    	process_lamp(lp15, lamps_32_63)    
	    process_lamp(lp16, lamps_32_63)    
		process_lamp(lp17, lamps_32_63)    
	--	process_LAMP(lp18, lamps_32_63)    
	--	process_LAMP(lp19, lamps_32_63)    
		
    end if
    
	-- process devices
    process_sw1p(sw00)
    process_sw1p(sw01)
		
end loop 