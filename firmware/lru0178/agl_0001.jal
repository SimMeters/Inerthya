------------------------------------------------------------------------------------------------------------------------
-- Copyright (c) 2015, SimMeters.
-- All rights reserved. Released under the BSD license.
-- agl_0001.jal 1.0 01/01/2014 (Radar Altimeter 0-5000ft UH1-D)

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
var float agl = 0.0

------------------------------------------------------------------------------------------------------------------------
-- Initialization
------------------------------------------------------------------------------------------------------------------------
src1    = 0
dst1    = 7560
set_vid2905()
src1    = 7560
dst1    = 0
set_vid2905()
src1    = 0
dst1    = 0

setup_can_init()
add_can_rxfilter(id_request_bootloader)
add_can_rxfilter(id_lamps_0_31)
add_can_rxfilter(id_radio_height)
setup_can_end()

led_l   = off
led_r   = off

------------------------------------------------------------------------------------------------------------------------
-- Main Loop
------------------------------------------------------------------------------------------------------------------------
forever loop

    request_bootloader("agl_0001")

    cf = get_can_frame(id_lamps_0_31)
    if(cf.dlc > 0) then
    
        led_l = ((get_can_uint32(cf) & mask_lamp_00) != 0)
        led_r = ((get_can_uint32(cf) & mask_lamp_00) != 0)
    
    end if

    cf = get_can_frame(id_radio_height)
    if(cf.dlc > 0) then

        agl = get_can_float(cf) * float(3.2808) -- CANAerospace meters to feets

        if (agl <= float(0)) then
            dst1 = 0
        elsif ((agl > float(0)) & (agl <= float(100))) then
            dst1 = dword(agl * float(24))
        elsif ((agl > float(100)) & (agl <= float(125))) then
            dst1 = dword(2400 + ((agl - float(100)) * float(24.96)))
        elsif ((agl > float(125)) & (agl <= float(150))) then
            dst1 = dword(3024 + ((agl - float(125)) * float(24)))
        elsif ((agl > float(150)) & (agl <= float(200))) then
            dst1 = dword(3624 + ((agl - float(150)) * float(24.96)))
        elsif ((agl > float(200)) & (agl <= float(500))) then
            dst1 = dword(4872 + ((agl - float(200)) * float(1.84)))
        elsif ((agl > float(500)) & (agl <= float(1000))) then
            dst1 = dword(5424 + ((agl - float(500)) * float(1.344)))
        elsif ((agl > float(1000)) & (agl <= float(5000))) then
            dst1 = dword(6096 + ((agl - float(1000)) * float(0.36)))
        elsif (agl > float(5000)) then
            dst1 = 7560
        end if

        set_vid2905()

    end if

end loop