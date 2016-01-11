------------------------------------------------------------------------------------------------------------------------
-- Copyright (c) 2015, SimMeters
-- All rights reserved. Released under the BSD license.
-- KT1B_RAL.jal 1.0 01/01/2014 (KT1B Radar Altimeter)

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
include atachapters     -- Library constants ATA Chapters
include canaerospace    -- Constants for CANAerospace
include lru0180         -- Include For LRU Gauge Device Type
include canbus          -- CanBus Library

------------------------------------------------------------------------------------------------------------------------
-- Variables Declaration
------------------------------------------------------------------------------------------------------------------------
var can_frame cf
var float ral = 0.0
var float rdh = 0.0

------------------------------------------------------------------------------------------------------------------------
-- Initialization
------------------------------------------------------------------------------------------------------------------------
_usec_delay(1000000)

led_l = on
led_r = on

srca = 0
dsta = 7560
srcb = 0
dstb = 7560

set_vid2805()
srca = 7560
dsta = 0
srcb = 7560
dstb = 0

set_vid2805()
srca = 0
dsta = 0
srcb = 0
dstb = 0

setup_can_init()
add_can_rxfilter(id_request_bootloader)
add_can_rxfilter(id_lamps_0_31)
add_can_rxfilter(id_radio_height)
add_can_rxfilter(id_decision_height)
setup_can_end()

led_l = off
led_r = off

------------------------------------------------------------------------------------------------------------------------
-- DH Encoder Process
------------------------------------------------------------------------------------------------------------------------
isr_encoder_enable() -- because we use encoder for setting DH
procedure isr_process_encoder() is pragma interrupt

    if (INTCON_TMR0IF) then
        
		var byte val_pa = PORTB_RB0
        
		if(val_pa != lat_pa) then
        
            var byte val_pb = PORTB_RB1
            
			if(val_pb != lat_pb) then
                
				var byte value = (lat_pb ^ val_pa)
                
				if(value == 0x00) then

					send_can_data(id_rxdata, DEVICE_ENCODER, DECISION_HEIGHT_DEC)
                
				elsif(value == 0x01) then
					
					send_can_data(id_rxdata, DEVICE_ENCODER, DECISION_HEIGHT_INC)
                
				end if
                
				lat_pb = val_pb
            
			end if
            
			lat_pa = val_pa
			
        end if
        
		isr_encoder_reset()
    
	end if

end procedure

------------------------------------------------------------------------------------------------------------------------
-- Main Loop
------------------------------------------------------------------------------------------------------------------------
forever loop 
    
    adjust_vid2805()
    request_bootloader("KT1B_RAL")

    cf = get_can_frame(id_lamps_0_31)
    if(cf.dlc > 0) then

        led_r = ((get_can_uint32(cf) & mask_lamp_00) != 0)

    end if

    cf = get_can_frame(id_radio_height)
    if(cf.dlc > 0) then
		
        ral = get_can_float(cf) * float(3.2808)

        if (ral <= float(0)) then
            dsta = 0
        elsif (ral > float(0) & ral <= float(500)) then
            dsta = dword(ral * float(8.64))
        elsif (ral > float(500) & ral <= float(2500)) then
            dsta = dword(4320 + ((ral - 500) * float(1.2)))
        elsif (ral > float(2500)) then
            dsta = 6720
        end if

    end if

    cf = get_can_frame(id_decision_height)
    if(cf.dlc > 0) then

        rdh = get_can_float(cf) * float(3.2808)

        if (rdh <= float(0)) then
            dstb = 0
        elsif (rdh > float(0) & rdh <= float(500)) then
            dstb = dword(rdh * float(8.64))
        elsif (rdh > float(500) & rdh <= float(2500)) then
            dstb = dword(4320 + ((rdh - 500) * float(1.2)))
        elsif (rdh > float(2500)) then
            dstb = 6720
        end if

        dstb = dstb + 60 -- mechanical compensation
        
    end if

    if(ral < rdh) then
        led_l = 1
    else
        led_l = 0
    end if

    set_vid2805()

end loop