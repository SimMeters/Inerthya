------------------------------------------------------------------------------------------------------------------------
-- Copyright (c) 2015, SimMeters
-- All rights reserved. Released under the BSD license.
-- vvi_0011.jal 1.0 01/01/2014 (A10C Vertical Speed Indicator 6,000 FPM AZ)

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
var float vvi = 0.0

------------------------------------------------------------------------------------------------------------------------
-- Initialization
------------------------------------------------------------------------------------------------------------------------
_usec_delay(1000000)

led_l = on
led_r = on

srca = 0
dsta = 7560
set_position_a()
srca = 7560
dsta = 0
set_position_a()
srca = 0
dsta = 0

setup_can_init()
add_can_rxfilter(id_request_bootloader)
add_can_rxfilter(id_lamps_0_31)
add_can_rxfilter(id_altitude_rate)
setup_can_end()

led_l = off
led_r = off

------------------------------------------------------------------------------------------------------------------------
-- Main Loop
------------------------------------------------------------------------------------------------------------------------
forever loop 
    
    adjust_position_a()
    request_bootloader("vvi_0011")

    cf = get_can_frame(id_lamps_0_31)
    if(cf.dlc > 0) then
    
        led_l = ((get_can_uint32(cf) & mask_lamp_00) != 0)
        led_r = ((get_can_uint32(cf) & mask_lamp_00) != 0)
    
    end if
    
	cf = get_can_frame(id_altitude_rate)
    if(cf.dlc > 0) then

        vvi = ((get_can_float(cf) * float(196.8503)) + float(6000)) -- Vertical Speed m/s to fpm

        if (vvi >= float(0) & vvi <= float(2000)) then  -- -6000 a -4000 FPM
            dsta = dword(vvi * float(0.33))
        elsif (vvi > float(2000) & vvi <= float(5000)) then -- -4000 a -1000 FPM
            dsta = dword(float(660) + ((vvi - float(2000)) * float(0.72)))
        elsif (vvi > float(5000) & vvi <= float(7000)) then -- -1000 a 1000 FPM
            dsta = dword(float(2820) + ((vvi - float(5000)) * float(0.96)))
        elsif (vvi > float(7000) & vvi <= float(10000)) then -- 1000 a 4000 FPM
            dsta = dword(float(4740) + ((vvi - float(7000)) * float(0.72)))
        elsif (vvi > float(10000) & vvi <= float(12000)) then -- 1000 a 4000 FPM
            dsta = dword(float(6900) + ((vvi - float(10000)) * float(0.33)))
        elsif (vvi > float(12000)) then
            dsta = 7560
        end if

        set_position_a()

	end if

end loop