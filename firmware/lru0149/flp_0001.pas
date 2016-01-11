------------------------------------------------------------------------------------------------------------------------
-- Copyright (c) 2015, SimMeters.
-- All rights reserved. Released under the BSD license.
-- flp_0001.jal 1.0 01/01/2015 (Flap Indicator 2 pointers 49mm Caravelle Project)

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
include lru0149      -- Include For LRU Gauge Device Type
include canbus       -- Library for CANBus

------------------------------------------------------------------------------------------------------------------------
-- Variables Declaration
------------------------------------------------------------------------------------------------------------------------
var can_frame cf
var float fp1 = 0.0
var float fp2 = 0.0

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
set_jukenX40()
srca = 7560
dsta = 0
srcb = 7560
dstb = 0
set_jukenX40()
srca = 0
dsta = 0
srcb = 0
dstb = 0

setup_can_init()
add_can_rxfilter(id_request_bootloader)
add_can_rxfilter(id_lamps_0_31)
add_can_rxfilter(id_flaps_lever_position)
setup_can_end()

led_l = off
led_r = off

------------------------------------------------------------------------------------------------------------------------
-- Main Loop
------------------------------------------------------------------------------------------------------------------------
forever loop

    request_bootloader("flp_0001")
	
    cf = get_can_frame(id_lamps_0_31)
    if(cf.dlc > 0) then
    
        led_l = ((get_can_uint32(cf) & mask_lamp_00) != 0)
        led_r = ((get_can_uint32(cf) & mask_lamp_00) != 0)
    
    end if
	
    cf = get_can_frame(id_flaps_lever_position)
    if(cf.dlc > 0) then
		
        fp1 = get_can_float(cf) -- Flap degrees position

		if (fp1 <= float(0)) then
            dsta = 0
		elsif ((fp1 > float(0)) & (fp1 <= float(5))) then
            dsta = dword(fp1 * float(552))
		elsif ((fp1 > float(5)) & (fp1 <= float(10))) then
			dsta = dword(2760 + float((fp1 - 5) * float(240)))
		elsif ((fp1 > float(10)) & (fp1 <= float(20))) then
			dsta = dword(3960 + float((fp1 - 10) * float(144)))
		elsif ((fp1 > float(20)) & (fp1 <= float(35))) then
			dsta = dword(5400 + float((fp1 - 20) * float(112)))
        elsif (fp1 > float(35)) then
            dsta = 7080
        end if            

		dstb = dsta -- Now only one indicator linked two pointers
		
		set_jukenX40()
    
    end if

end loop