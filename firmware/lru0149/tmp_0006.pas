------------------------------------------------------------------------------------------------------------------------
-- Copyright (c) 2015, SimMeters.
-- All rights reserved. Released under the BSD license.
-- tmp_0006.jal 1.0 01/01/2015 (Transmission OIL Temp 49mm UH1D AZ)

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
var float tmp  = 0.0

------------------------------------------------------------------------------------------------------------------------
-- Initialization
------------------------------------------------------------------------------------------------------------------------
_usec_delay(1000000)

led_l = on
led_r = on

srca = 0
dsta = 7560
set_vid2905() -- set_vid2905P()
srca = 7560
dsta = 0
set_vid2905() -- set_vid2905P()
srca = 0
dsta = 0

setup_can_init()
add_can_rxfilter(id_request_bootloader)
add_can_rxfilter(id_lamps_0_31)
add_can_rxfilter(id_gearbox_1_oil_temperature)
setup_can_end()

led_l = off
led_r = off

------------------------------------------------------------------------------------------------------------------------
-- Main Loop
------------------------------------------------------------------------------------------------------------------------
forever loop

    request_bootloader("tmp_0006")
	
    cf = get_can_frame(id_lamps_0_31)
    if(cf.dlc > 0) then
    
        led_l = ((get_can_uint32(cf) & mask_lamp_00) != 0)
        led_r = ((get_can_uint32(cf) & mask_lamp_00) != 0)
    
    end if

    cf = get_can_frame(id_gearbox_1_oil_temperature)
    if(cf.dlc > 0) then

        tmp = get_can_float(cf) + float(70) -- Range -70 a +150 C

        if(tmp <= float(0)) then
            dsta = 0
        elsif ((tmp > float(0)) & (tmp <= float(20))) then
            dsta = dword(tmp * float(21.6))
        elsif ((tmp > float(20)) & (tmp <= float(70))) then
            dsta = dword(432 + ((tmp - 20) * float(22.08)))
        elsif ((tmp > float(70)) & (tmp <= float(120))) then
            dsta = dword(1536 + ((tmp - 70) * float(21.12)))
        elsif ((tmp > float(120)) & (tmp <= float(170))) then
            dsta = dword(2592 + ((tmp - 120) * float(30.24)))
        elsif ((tmp > float(170)) & (tmp <= float(220))) then
            dsta = dword(4104 + ((tmp - 170) * float(39.36)))
        elsif (tmp > float(220)) then
            dsta = 6072
        end if

		set_vid2905() -- set_vid2905P()
	
    end if

end loop