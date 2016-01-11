------------------------------------------------------------------------------------------------------------------------
-- Copyright (c) 2015, SimMeters.
-- All rights reserved. Released under the BSD license.
-- pnl_0239.jal 1.0 01/01/2015 (A-10C MIP Panel Miscellaneus)
-- Notes: The common goes to ground because ISR Encoders Output 22 is really unused

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
add_can_rxfilter(id_lamps_32_63)
add_can_rxfilter(id_lamps_64_95)
setup_can_end()

set_pin(P21, low)
set_pin(P22, high)

------------------------------------------------------------------------------------------------------------------------
-- Objects Definition
------------------------------------------------------------------------------------------------------------------------
var can_frame cf
var dword lamps_32_63
var dword lamps_64_95

var volatile lamp lp00 = new_lamp(P14, mask_lamp_15) -- gun ready
var volatile lamp lp01 = new_lamp(p15, mask_lamp_03) -- steering enabled
var volatile lamp lp02 = new_lamp(p16, mask_lamp_07) -- marker beacon
var volatile lamp lp03 = new_lamp(p17, mask_lamp_30) -- canopy open
var volatile lamp lp04 = new_lamp(p26, mask_lamp_04) -- left fire handle
var volatile lamp lp05 = new_lamp(p27, mask_lamp_05) -- apu fire handle
var volatile lamp lp06 = new_lamp(p28, mask_lamp_06) -- right fire handle

var volatile en2p en00 = new_en2p(p05, p06, HDG_BUG_INC, HDG_BUG_DEC)
var volatile en2p en01 = new_en2p(p07, p08, CRS_BUG_INC, CRS_BUG_DEC)
var volatile en2p en02 = new_en2p(p09, p10, ADI_SET_INC, ADI_SET_DEC)

var volatile sw2p sw00 = new_sw2p(p11, P22, EXT_STORES_JETT_ON, EXT_STORES_JETT_OFF)
var volatile sw2p sw01 = new_sw2p(p12, P22, HARS_FAST_ERECT_ON, HARS_FAST_ERECT_OFF)
var volatile sw3p sw02 = new_sw3p(p32, p33, P22, FIRE_RENG_DISC_ON, FIRE_ENG_DISC_OFF, FIRE_LENG_DISC_ON)
var volatile sw2p sw03 = new_sw2p(p34, P22, FIRE_RENG_PULL_ON, FIRE_RENG_PULL_OFF)
var volatile sw2p sw04 = new_sw2p(p35, P22, FIRE_APU_PULL_ON, FIRE_APU_PULL_OFF)
var volatile sw2p sw05 = new_sw2p(p36, P22, FIRE_LENG_PULL_ON, FIRE_LENG_PULL_OFF)

------------------------------------------------------------------------------------------------------------------------
-- Process encoders
------------------------------------------------------------------------------------------------------------------------
isr_encoder_enable() -- because we use encoders
procedure isr_encoder_process() is pragma interrupt

    if (INTCON_TMR0IF) then
        
		process_en2p(en00)
        process_en2p(en01)
        process_en2p(en02)
        isr_encoder_reset()
    
	end if

end procedure

------------------------------------------------------------------------------------------------------------------------
-- Main Loop
------------------------------------------------------------------------------------------------------------------------
forever loop 

    -- request bootloader for auto update (do not remove)
    request_bootloader("pnl_0239")

    -- process lamps
    cf = get_can_frame(id_lamps_32_63)
    if(cf.dlc > 0) then

        lamps_32_63 = get_can_uint32(cf)
        process_lamp(lp03, lamps_32_63)    

    end if

    cf = get_can_frame(id_lamps_64_95)
    if(cf.dlc > 0) then

        lamps_64_95 = get_can_uint32(cf)
        process_lamp(lp00, lamps_64_95)    
        process_lamp(lp01, lamps_64_95)    
        process_lamp(lp02, lamps_64_95)    
        process_lamp(lp04, lamps_64_95)    
        process_lamp(lp05, lamps_64_95)    
        process_lamp(lp06, lamps_64_95)
		
    end if

    -- process devices
    process_sw2p(sw00)
    process_sw2p(sw01)
    process_sw3p(sw02)
    process_sw2p(sw03)
    process_sw2p(sw04)
    process_sw2p(sw05)

end loop