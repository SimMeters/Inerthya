------------------------------------------------------------------------------------------------------------------------
-- Copyright (c) 2015, SimMeters.
-- All rights reserved. Released under the BSD license.
-- alt_0008.jal 1.0 01/01/2014 (Double Pointer Altimeter Feets 78M UH1D)

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
include atachapters  -- Library for ATA Chapters constants
include canaerospace -- Library for CAN Aerospace constants
include lru0178      -- Include For LRU Gauge Device Type
include canbus       -- Library for CANBus

------------------------------------------------------------------------------------------------------------------------
-- Variables Declaration
------------------------------------------------------------------------------------------------------------------------
var can_frame cf
var float alt   = 0.0

------------------------------------------------------------------------------------------------------------------------
-- Init
------------------------------------------------------------------------------------------------------------------------
src1    = 0
dst1    = 8640
setMOTD2()
src1    = 0
dst1    = 0

src2    = 0
dst2    = 8640
setMOTD2()
src2    = 0
dst2    = 0

setup_can_init()
add_can_rxfilter(id_request_bootloader)
add_can_rxfilter(id_lamps_0_31)
add_can_rxfilter(id_baro_corrected_altitude)
setup_can_end()

led_l   = off
led_r   = off

------------------------------------------------------------------------------------------------------------------------
-- QNH Encoder Process
------------------------------------------------------------------------------------------------------------------------
isr_encoder_enable() -- because we use encoder for setting QNH
procedure isr_process_encoder() is pragma interrupt

  if (INTCON_TMR0IF) then
        
		var byte val_pa = PORTB_RB0
        
		if(val_pa != latPA) then
        
            var byte val_pb = PORTB_RB1
            
			if(val_pb != latPB) then
                
				var byte value = (latPB ^ val_pa)
                
				if(value == 0x00) then
                
					send_can_data(id_rxdata, device_encoder, qnh_enc_inc)
                
				elsif(value == 0x01) then
					
					send_can_data(id_rxdata, device_encoder, qnh_enc_dec)
                
				end if
                
				latPB = val_pb
            
			end if
            
			latPA = val_pa
			
        end if
        
		isr_encoder_reset()
    
	end if

end procedure

------------------------------------------------------------------------------------------------------------------------
-- Main Loop
------------------------------------------------------------------------------------------------------------------------
forever loop

    adjustMOTD2()

    request_bootloader("alt_0008")

      cf = get_can_frame(id_lamps_0_31)
    if(cf.dlc > 0) then
    
        led_l = ((get_can_uint32(cf) & mask_lamp_00) != 0)
        led_r = ((get_can_uint32(cf) & mask_lamp_00) != 0)
    
    end if

    cf = get_can_frame(id_baro_corrected_altitude)
    if(cf.dlc > 0) then

        alt = get_can_float(cf) * float(3.2808) -- CANAerospace Altitude meters to feets

        if (alt >= float(0) & alt <= float(60000)) then

            dst1 = dword(alt * float(0.864)) % 8640
            dst2 = dword(alt * float(8.64)) % 8640

            if ((src1 > dst1) & ((src1 - dst1) > 4320)) then
                dst1 = dst1 + 8640
            elsif ((src1 < dst1) & ((dst1 - src1) > 4320)) then
                src1 = src1 + 8640
            end if

            if ((src2 > dst2) & ((src2 - dst2) > 4320)) then
                dst2 = dst2 + 8640
            elsif ((src2 < dst2) & ((dst2 - src2) > 4320)) then
                src2 = src2 + 8640
            end if

            -- Set Double Pointer Position
            setMOTD2()
            src1 = src1 % 8640
            src2 = src2 % 8640

        end if

    end if

end loop