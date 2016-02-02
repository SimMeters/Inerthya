------------------------------------------------------------------------------------------------------------------------
-- Copyright (c) 2016, SimMeters.com
-- All rights reserved. Released under the BSD license.
-- KT1B_FLP.jal 1.0 01/01/2016 (KT1B Display Flap Indicator)

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
include canaerospace -- Include library for CANAerospace ID's
include lru0000      -- Include library for LRU Type
include canbus       -- Include library for CANBus
include sgcdisplay   -- 4DSystems Display Library

------------------------------------------------------------------------------------------------------------------------
-- Constants Declaration
------------------------------------------------------------------------------------------------------------------------
const byte FLAP_SP[1] = { 32 }
const byte FLAP_BP[1] = { 33 }
const byte FLAP_UP[1] = { 34 }
const byte FLAP_TO[1] = { 35 }
const byte FLAP_LD[1] = { 36 }

------------------------------------------------------------------------------------------------------------------------
-- Variables Declaration
------------------------------------------------------------------------------------------------------------------------
var can_frame cf
var dword flp 		= 0
var dword flp_lat 	= 0

------------------------------------------------------------------------------------------------------------------------
-- Initialization
------------------------------------------------------------------------------------------------------------------------
_usec_delay(1000000) -- 1sec delay on start

set_pin(p07, low)
_usec_delay(100000)
set_pin(p07, high)
_usec_delay(1000000)

usart_enable()
set_autobaud()
clear_screen()
prints(0x01, 0x01, 0x00, 0xFF, 0xFF, FLAP_BP)

setup_can_init()
add_can_rxfilter(id_request_bootloader)
add_can_rxfilter(id_flaps_lever_position)
setup_can_end()

set_pin(P21, high)
set_pin(P22, low)

------------------------------------------------------------------------------------------------------------------------
-- Main Loop
------------------------------------------------------------------------------------------------------------------------
forever loop

    request_bootloader("KT1B_FLP")

    cf = get_can_frame(id_flaps_lever_position)
    if(cf.dlc > 0) then
		
        flp = dword(get_can_float(cf) * float(1))

        if(flp_lat != flp) then
			
		flp_lat = flp
            	opaque_text(true)	        
	        
            	case flp_lat of
            
                	1: block 
                    		prints(0x01, 0x01, 0x00, 0xFF, 0xFF, FLAP_UP)
                	end block
            
                	2: block 
                    		prints(0x01, 0x01, 0x00, 0xFF, 0xFF, FLAP_TO)
                	end block

                	3: block 
                    		prints(0x01, 0x01, 0x00, 0xFF, 0xFF, FLAP_LD)
                	end block

                	4: block 
                    		prints(0x01, 0x01, 0x00, 0xFF, 0xFF, FLAP_BP)
                	end block

            	end case

        end if

    end if

end loop
