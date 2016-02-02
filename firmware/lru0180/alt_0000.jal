------------------------------------------------------------------------------------------------------------------------
-- Copyright (c) 2015, SimMeters
-- All rights reserved. Released under the BSD license.
-- alt_0000.jal 1.0 01/01/2015 (Double Pointer Altimeter ft 80MM)

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
var float alt = 0.0

------------------------------------------------------------------------------------------------------------------------
-- Initialization
------------------------------------------------------------------------------------------------------------------------
_usec_delay(1000000)

led_l = on
led_r = on

srca = 0
dsta = 8640
set_position_ab()

srcb = 0
dstb = 8640
set_position_ab()

srca = 0
dsta = 0
srcb = 0
dstb = 0

setup_can_init()
add_can_rxfilter(id_request_bootloader)
add_can_rxfilter(id_lamps_0_31)
add_can_rxfilter(id_baro_corrected_altitude)
setup_can_end()

led_l = off
led_r = off

------------------------------------------------------------------------------------------------------------------------
-- QNH Encoder Process
------------------------------------------------------------------------------------------------------------------------
isr_encoder_enable() -- because we use encoder for setting QNH
procedure isr_process_encoder() is pragma interrupt

    if (INTCON_TMR0IF) then
        
		var byte val_pa = PORTB_RB0
        
		if(val_pa != lat_pa) then
        
            var byte val_pb = PORTB_RB1
            
			if(val_pb != lat_pb) then
                
				var byte value = (lat_pb ^ val_pa)
                
				if(value == 0x00) then
                
					send_can_data(id_rxdata, DEVICE_ENCODER, QNH_ENC_DEC)
                
				elsif(value == 0x01) then
					
					send_can_data(id_rxdata, DEVICE_ENCODER, QNH_ENC_INC)
                
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
    
    adjust_position_ab()
    request_bootloader("alt_0000")

    cf = get_can_frame(id_lamps_0_31)
    if(cf.dlc > 0) then
    
        led_l = ((get_can_uint32(cf) & mask_lamp_00) != 0)
        led_r = ((get_can_uint32(cf) & mask_lamp_00) != 0)
    
    end if
    
	cf = get_can_frame(id_baro_corrected_altitude)
    if(cf.dlc > 0) then
    
		alt = get_can_float(cf) * float(3.2808)    
		
		dsta = dword(alt * float(0.864)) % 8640
        dstb = dword(alt * float(8.64)) % 8640

		if ((srca > dsta) & ((srca - dsta) > 4320)) then
			dsta = dsta + 8640
		elsif ((srca < dsta) & ((dsta - srca) > 4320)) then
			srca = srca + 8640
		end if

		if ((srcb > dstb) & ((srcb - dstb) > 4320)) then
			dstb = dstb + 8640
		elsif ((srcb < dstb) & ((dstb - srcb) > 4320)) then
			srcb = srcb + 8640
		end if

		set_position_ab()
		srca = srca % 8640
		srcb = srcb % 8640

    end if    

end loop