------------------------------------------------------------------------------------------------------------------------
-- Copyright (c) 2015, SimMeters
-- All rights reserved. Released under the BSD license.
-- alt_0006.jal 1.0 01/01/2015 (Digital Altimeter 5Digit 60MM)

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
include lru0160         -- Include For LRU Gauge Device Type
include canbus          -- CanBus Library
include sgcdisplay      -- SGC Display Library

------------------------------------------------------------------------------------------------------------------------
-- Variables Declaration
------------------------------------------------------------------------------------------------------------------------
var can_frame cf
var float alt   = 0.0
var float qnh   = 0.0
var dword vqnh  = 0
var dword vqnhl = 0

------------------------------------------------------------------------------------------------------------------------
-- Initialization
------------------------------------------------------------------------------------------------------------------------
_usec_delay(1000000)

led_l = on
led_r = on

LATC_LATC3 = low
_usec_delay(100000)
LATC_LATC3 = high
_usec_delay(1000000)

usart_enable()
set_autobaud()
clear_screen()

print_inhg(0x01, 0x01, 0x00, 0xFF, 0xFF, dword(vqnh * float(2.9536)))
prints(0x06, 0x01, 0x00, 0xFF, 0xFF, "HG")
print_mbar(0x01, 0x02, 0x00, 0xFF, 0xFF, vqnh)
prints(0x06, 0x02, 0x00, 0xFF, 0xFF, "MB")
print_alt(0x00, 0x02, 0x01, 0xFF, 0xFF, dword(alt))

srca = 0
dsta = 8640
set_vid2905()
srca = 0
dsta = 0

setup_can_init()
add_can_rxfilter(id_request_bootloader)
add_can_rxfilter(id_lamps_0_31)
add_can_rxfilter(id_baro_correction)
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
                
					send_can_data(id_rxdata, device_encoder, qnh_enc_inc)
                
				elsif(value == 0x01) then
					
					send_can_data(id_rxdata, device_encoder, qnh_enc_dec)
                
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
    adjust_vid2905()
    request_bootloader("alt_0006")

    cf = get_can_frame(id_lamps_0_31)
    if(cf.dlc > 0) then
    
        led_l = ((get_can_uint32(cf) & mask_lamp_00) != 0)
        led_r = ((get_can_uint32(cf) & mask_lamp_00) != 0)
    
    end if

    cf = get_can_frame(id_baro_correction)
    if(cf.dlc > 0) then

         qnh = get_can_float(cf)
         vqnh = dword(qnh)
         
         if(vqnh != vqnhl) then
            
			vqnhl = vqnh
            
            print_inhg(0x01, 0x01, 0x00, 0xFF, 0xFF, dword(vqnh * float(2.9536)))
            prints(0x06, 0x01, 0x00, 0xFF, 0xFF, "HG")
            
            print_mbar(0x01, 0x02, 0x00, 0xFF, 0xFF, vqnh)
            prints(0x06, 0x02, 0x00, 0xFF, 0xFF, "MB")

		 end if

    end if    
    
	cf = get_can_frame(id_baro_corrected_altitude)
    if(cf.dlc > 0) then
    
        alt = get_can_float(cf) * float(3.2808)

        if (alt >= float(0) & alt <= float(60000)) then
        
            dsta = dword(alt * float(8.64)) % 8640

            if ((srca > dsta) & ((srca - dsta) > 4320)) then
                dsta = dsta + 8640
            elsif ((srca < dsta) & ((dsta - srca) > 4320)) then
                srca = srca + 8640
            end if                    
            
            print_alt(0x00, 0x02, 0x01, 0xFF, 0xFF, dword(alt))

            set_vid2905()
            srca = srca % 8640

        end if

    end if    

end loop