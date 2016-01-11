------------------------------------------------------------------------------------------------------------------------
-- Copyright (c) 2015, SimMeters.com
-- All rights reserved. Released under the BSD license.
-- KT1B_ASI.jal 1.0 01/01/2014 (KT1B Airspeed Indicator)

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
include sgcdisplay      -- 4DSystems Display Library

------------------------------------------------------------------------------------------------------------------------
-- Variables Declaration
------------------------------------------------------------------------------------------------------------------------
var can_frame cf
var float asi 	= 0.0
var float cas 	= 0.0
var dword macv 	= 0
var dword macl 	= 0

------------------------------------------------------------------------------------------------------------------------
-- Initialization
------------------------------------------------------------------------------------------------------------------------
_usec_delay(1000000)

led_l = on
led_r = on

LATC_LATC4 = low
_usec_delay(100000)
LATC_LATC4 = high
_usec_delay(1000000)

usart_enable()
set_autobaud()
clear_screen()

print_asi(0x02, 0x04, 0x01, 0xFF, 0xFF, dword(cas))
print_mach(0x02, 0x06, 0x01, 0xFF, 0xFF, macv)

srca = 0
dsta = 7560
set_vid2905()
srca = 7560
dsta = 0
set_vid2905()
srca = 0
dsta = 0

setup_can_init()
add_can_rxfilter(id_request_bootloader)
add_can_rxfilter(id_mach_number)
add_can_rxfilter(id_indicated_airspeed)
add_can_rxfilter(id_calibrated_airspeed)
setup_can_end()

led_l = off
led_r = off

------------------------------------------------------------------------------------------------------------------------
-- Index Speed Encoder Process
------------------------------------------------------------------------------------------------------------------------
isr_encoder_enable() -- because we use encoder for setting index speed
procedure isr_process_encoder() is pragma interrupt

    if (INTCON_TMR0IF) then
        
		var byte val_pa = PORTB_RB0
        
		if(val_pa != lat_pa) then
        
            var byte val_pb = PORTB_RB1
            
			if(val_pb != lat_pb) then
                
				var byte value = (lat_pb ^ val_pa)
                
				if(value == 0x00) then

					send_can_data(id_rxdata, DEVICE_ENCODER, CAS_SPEED_DEC)
                
				elsif(value == 0x01) then
					
					send_can_data(id_rxdata, DEVICE_ENCODER, CAS_SPEED_INC)
                
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
    
	opaque_text(true)
	request_bootloader("KT1B_ASI")

	cf = get_can_frame(id_mach_number)
	if(cf.dlc > 0) then
    
		macv = dword(get_can_float(cf) * float(100))
		if(macv != macl) then

			macl = macv
			print_mach(0x02, 0x06, 0x01, 0xFF, 0xFF, macv)

        	end if

    	end if

    	cf = get_can_frame(id_indicated_airspeed)
    	if(cf.dlc > 0) then
		
        	led_l 	= cf.data2
		led_r 	= led_l
        	asi = get_can_float(cf) * float(1.9438)

        	if (asi <= float(0)) then
            		dsta = 0
        	elsif (asi > float(0) & asi <= float(60)) then
            		dsta = dword(asi * float(8))
        	elsif (asi > float(60) & asi <= float(180)) then
            		dsta = dword(480 + ((asi - 60) * float(27.2)))
        	elsif (asi > float(180) & asi <= float(400)) then
            		dsta = dword(3744 + ((asi - 180) * float(16.8)))
        	elsif (asi > float(400)) then
            		dsta = 7440
        	end if

        	set_vid2905()

    	end if

    	cf = get_can_frame(id_calibrated_airspeed)
    	if(cf.dlc > 0) then

        	cas = get_can_float(cf) * float(1.9438)

        	if(asi > cas) then
            		prints(0x02, 0x04, 0x01, 0xFF, 0xFF, "OVSP")
        	else
            		print_asi(0x02, 0x04, 0x01, 0xFF, 0xFF, dword(cas))
        	end if

    	end if

end loop
