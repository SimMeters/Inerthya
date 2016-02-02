------------------------------------------------------------------------------------------------------------------------
-- Copyright (c) 2015, SimMeters.
-- All rights reserved. Released under the BSD license.
-- clk_0000.jal 1.0 01/01/2015 (Clock Hours Faceplate P-51 GA 60MM)

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
include atachapters     -- Library for ATA Chapters constants
include canaerospace    -- Library for CAN Aerospace constants
include lru0160         -- Library for LRU-0160 60MM gauge
include canbus          -- Library for CANBus

------------------------------------------------------------------------------------------------------------------------
-- Variables Declaration
------------------------------------------------------------------------------------------------------------------------
var can_frame cf
var float utc = 0.0

------------------------------------------------------------------------------------------------------------------------
-- Initialization
------------------------------------------------------------------------------------------------------------------------
_usec_delay(1000000)

led_l = on
led_r = on

srca = 0
dsta = 8640
set_jukenX40()
srcb = 0
dstb = 8640
set_jukenX40()
srca = 0
dsta = 0
srcb = 0
dstb = 0

setup_can_init()
add_can_rxfilter(id_request_bootloader)
add_can_rxfilter(id_lamps_0_31)
add_can_rxfilter(id_utc)
setup_can_end()

led_l = off
led_r = off

------------------------------------------------------------------------------------------------------------------------
-- Main Loop
------------------------------------------------------------------------------------------------------------------------
forever loop

    adjust_jukenX40()
	request_bootloader("clk_0000")
	
    cf = get_can_frame(id_lamps_0_31)
    if(cf.dlc > 0) then
    
        led_l = ((get_can_uint32(cf) & mask_lamp_00) != 0)
        led_r = ((get_can_uint32(cf) & mask_lamp_00) != 0)
    
    end if
	
    cf = get_can_frame(id_utc)
    if(cf.dlc > 0) then
    
        utc = get_can_float(cf)
        
        dsta = dword(utc * float(0.2)) % 8640
        dstb = dword(utc * float(2.4)) % 8640

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
            
        set_jukenX40()
        
        srca = srca % 8640
        srcb = srcb % 8640

	end if

end loop